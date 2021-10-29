# frozen_string_literal: true

module EntrisionReports
  module ReportsHelper
    def report_align(format)
      Reports::Base.text_alignment(format)
    end
  end
end
