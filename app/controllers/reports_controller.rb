# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_params
  skip_authorization_check if respond_to?(:skip_authorization_check)

  def index; end

  def show
    return unless can_view_report? params[:report].to_sym

    report = "Reports::#{params[:report].camelize}".constantize.new(@start_date, @end_date, { params: params, current_user_id: current_user.id })
    @viewer, @title, @headers, @formats, @results, @chart = report.get
    respond_to do |format|
      format.html { render 'report_viewer' }
      format.csv do
        if @viewer != 'pending'
          csv_string = CSV.generate do |csv|
            @headers.each do |header|
              csv << header
            end
            @results.each do |row|
              csv << row
            end
          end
          send_data csv_string
        else
          render 'report_viewer'
        end
      end
    end
  end

  def clear_cache
    ReportCache.all.each do |rc|
      rc.destroy
    end
    redirect_to reports_path
  end

  private

  def can_view_report?(report)
    return true if can? :show, report

    flash[:danger] = 'You man not veiw this report'
    redirect_to '/'
  end

  def set_params
    @start_date = store_date(:start_date, Date.today - 30.days)
    @end_date = store_date(:end_date, Date.today)
  end

  def store_date(symbol, default)
    value = params[symbol] || session[symbol] || default
    value = value.to_date
    session[symbol] = value
    value
  end
end
