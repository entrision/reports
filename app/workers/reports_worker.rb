# frozen_string_literal: true

class ReportsWorker
  include Sidekiq::Worker

  def perform(klass, start_date, end_date, options, cache_id)
    cache = ReportCache.find(cache_id)
    return unless cache.data.blank?

    report = klass.constantize.new(Date.parse(start_date), Date.parse(end_date), options)
    cache.data = report.data
    cache.chart = report.chart
    cache.data = [[0, 0]] if cache.data.blank?
    cache.save!
  end
end
