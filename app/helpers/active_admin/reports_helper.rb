# frozen_string_literal: true

module ActiveAdmin
  module ReportsHelper
    def set_dates
      start_date = store_date(:start_date, Date.today - 30.days)
      end_date = store_date(:end_date, Date.today)
      #  this is nasty due to ActiveAdmin
      return [start_date, end_date] # rubocop:disable Style/RedundantReturn
    end

    def store_date(symbol, default)
      value = params[symbol] || session[symbol] || default
      return value if value.is_a? Date

      value = value.to_date
      session[symbol] = value
      value
    end

    def report_align(format)
      Reports::Base.text_alignment(format)
    end
  end
end
