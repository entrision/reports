module EntrisionReports
  module ReportsHelper
    def report_align(format)
      if format == "Integer" or format == "Money"
        return "right"
      elsif format == "String"
        return "left"
      end
      return "center"
    end
  end
end
