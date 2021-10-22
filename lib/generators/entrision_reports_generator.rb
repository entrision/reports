# frozen_string_literal: true

require 'rails/generators'

module EntrisionReports
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Install Entrision Reports Files'
      def install
        puts 'Installing Things'
        # TODO: copy admin/reports.rb to project as a template
      end
    end
  end
end

