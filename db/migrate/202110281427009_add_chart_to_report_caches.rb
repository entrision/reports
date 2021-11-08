class AddChartToReportCaches < ActiveRecord::Migration[6.0]
  def change
    unless column_exists? :report_caches, :chart
      add_column :report_caches, :chart, :json
    end
  end
end
