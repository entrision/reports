# frozen_string_literal: true

require 'rails/generators'

module EntrisionReports
  module Generators
    class ReportGenerator < Rails::Generators::NamedBase

      source_root File.expand_path('templates', __dir__)

      desc 'Generate a report files'
      def install_files
        @underscore_name = file_name.underscore.downcase
        template('report.rb', 'lib/reports/' + "#{@underscore_name.singularize}.rb")
      end
    end
  end
end

