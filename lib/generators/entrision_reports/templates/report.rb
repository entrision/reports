# frozen_string_literal: true

module Reports # :nodoc:
  class <%= class_name %> < Reports::Base # :nodoc:
    def view
      'one column'
    end

    def title
      'Report Title'
    end

    def headers
      [] << %w[]
    end

    def formats
      %w[]
    end

    def generate_data
      results = []
      (@start_date..@end_date).each do |day|
       results << day
      end

      results
    end

    def chart
      data = []
      generate_data.each do |row|
        data << [row[0], row[1]]
      end
      { title: title, type: 'area', data: data }
    end
  end
end
