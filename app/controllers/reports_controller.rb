class ReportsController < ApplicationController
  before_action :set_params
  skip_authorization_check if self.respond_to?(:skip_authorization_check)

  def index
  end

  def show
    if can? :show, params[:report].to_sym
      report = "Reports::#{params[:report].camelize}".constantize.new(@start_date, @end_date, { params: params })
      @viewer, @title, @headers, @formats, @results, @chart  = report.get
      @needs_dates = report.needs_dates?
      render "report_viewer"
    else
      flash[:danger] = "You man not veiw this report"
      redirect_to '/'
    end
  end
private
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
