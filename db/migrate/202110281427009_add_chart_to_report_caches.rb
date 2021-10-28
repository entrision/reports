class AddChartToReportCaches < ActiveRecord::Migration[6.0]
  def change
    add_column :report_caches, :chart, :json
  end
end
