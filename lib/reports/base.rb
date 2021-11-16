# frozen_string_literal: true

# A module to hold all report definitions
module Reports
  # Base class for all reports, has useful methods for writing report definitions.
  class Base
    attr_accessor :start_date, :end_date, :params, :options

    def self.text_alignment(format)
      return 'right' if %w[Integer Money].include?(format)
      return 'left' if format == 'String'

      'center'
    end

    def initialize(start_date = Date.today - 31.days, end_date = Date.today, options = {})
      @start_date = start_date
      @end_date = end_date
      @options = options
      @params = options[:params]
      @cache = ReportCache.where(start_date: @start_date, end_date: @end_date, report_name: self.class.to_s).first_or_create
    end

    # The title of the report
    def title
      'New Report'
    end

    # The view to render the report
    def view
      'single'
    end

    # Headers to use as an array, Headers must match data columns
    def headers
      [['Data']]
    end

    # Formats to use for data columns. Currently supports 'String', 'Number', and 'Percentage'
    def formats
      ['String']
    end

    # The actual data in the report
    def data
      @data ||= generate_data
      @data
    end

    # Generates the actually data in an Array or Arrays
    def generate_data
      [['one']]
    end

    # Abstract method to build a chart based on +data+
    def chart
      {}
    end

    def expire_cache
      return unless @cache.expires_at.blank? || DateTime.now > @cache.expires_at

      @cache.destroy
      @cache = ReportCache.where(start_date: @start_date, end_date: @end_date, report_name: self.class.to_s).first_or_create
    end

    def fill_cache
      return unless @cache.data.blank?
      return unless @cache.expires_at < DateTime.now

      if Rails.env.development?
        @cache.update_column :expires_at, DateTime.now + 2.minutes
        ReportsWorker.new.perform(self.class.to_s, @start_date.to_s, @end_date.to_s, @options, @cache.id)
      else
        @cache.update_column :expires_at, DateTime.now + 2.hours
        ReportsWorker.perform_async(self.class, @start_date, @end_date, @options, @cache.id)
      end
    end

    # A simple method that calls and returns all the data to render a report
    def get
      expire_cache
      fill_cache
      return 'pending', title, @cache.id if @cache.data.blank?

      return view, title, headers, formats, @cache.data, @cache.chart
    end

    # Do we need  dates? Overload if we do not.
    def needs_dates?
      true
    end
  end
end
