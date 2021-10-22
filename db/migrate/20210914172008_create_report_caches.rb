# frozen_string_literal: true

class CreateReportCaches < ActiveRecord::Migration[6.0]
  def change
    create_table :report_caches do |t|
      t.date :start_date
      t.date :end_date
      t.datetime :expires_at
      t.string :report_name
      t.json :data

      t.timestamps
    end
  end
end
