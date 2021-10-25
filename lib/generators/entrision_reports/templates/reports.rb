# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveA dmin.register_page 'Reports' do
  menu label: 'Reports'

  content title: 'Reports' do
    columns do
      column do
        panel 'Report Group' do
          ul do
            li link_to 'Example Report', admin_report_viewer_path(report: 'example')
          end
        end
      end
      column do
        panel 'Report Group' do
          ul do

          end
        end
      end
      column do
        panel 'Report Group' do

        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
