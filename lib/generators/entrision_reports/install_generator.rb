# frozen_string_literal: true

require 'rails/generators'

module EntrisionReports
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Install basic report files'
      def install_files
        template('reports.rb', 'app/admin/reports.rb')
      end
    end
  end
end

