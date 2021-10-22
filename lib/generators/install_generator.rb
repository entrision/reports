# frozen_string_literal: true

require 'rails/generators'

module EntrisionReports
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      def install_files
        create_file "app/admin/reports.rb", <<- FILE
          some text
        FILE
      end
    end
  end
end

# also need a report generator
