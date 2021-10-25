# frozen_string_literal: true

module EntrisionReports
  class Engine < Rails::Engine
    initializer :entrision_reports_engine do
      ActiveAdmin.application.load_paths << File.dirname(__FILE__) + '/admin'

      # raise ActiveAdmin.application.load_paths.to_s
    end

    initializer :append_migrations do |app|


      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
