# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
if defined?(ActiveAdmin)
  ActiveAdmin.register_page 'Report Viewer' do
    menu false

    content title: 'Report Viewer' do
      dates = set_dates # I would love to not repeat this but AA makes it difficult
      @start_date = dates[0]
      @end_date = dates[1]
      report = "Reports::#{params[:report].camelize}".constantize.new(@start_date, @end_date, { params: params })
      @viewer, @title, @headers, @formats, @results, @chart = report.get

      if @viewer == 'pending'
        render partial: 'pending', locals: { job_id: @headers }
      elsif @viewer == 'single'
        panel @title do
          render partial: 'single', locals: { headers: @headers, results: @results, formats: @formats }
        end
      elsif @viewer == 'one column'
        if @chart
          panel "#{@title} - #{@chart[:title]}" do
            render partial: 'chart', locals: { chart: @chart }
          end
        end
        panel @title do
          render partial: 'single', locals: { headers: @headers, results: @results, formats: @formats }
        end
      elsif @viewer == 'two column'
        columns do
          column do
            panel "#{@title} - #{@chart[:title]}" do
              render partial: 'chart', locals: { chart: @chart }
            end
          end
          column do
            panel @title do
              render partial: 'single', locals: { headers: @headers, results: @results, formats: @formats }
            end
          end
        end
      elsif @viewer == 'duplex two column'
        columns do
          column do
            @chart.each do |c|
              panel "#{@title} - #{c[:title]}" do
                render partial: 'chart', locals: { chart: c }
              end
            end
          end
          column do
            panel @title do
              render partial: 'single', locals: { headers: @headers, results: @results, formats: @formats }
            end
          end
        end

      else
        panel @title do
          h1 'Invalid Report Definition'
        end
      end
    end

    sidebar 'Options' do
      dates = set_dates
      @start_date = dates[0]
      @end_date = dates[1]
      form action: admin_report_viewer_set_params_path, method: :post do |f|
        f.label 'Start Date'
        f.input :start_date, type: :date, value: @start_date, name: :start_date
        f.label 'End Date'
        f.input :end_date, type: :date, value: @end_date, name: :end_date
        f.input :report, type: :hidden, value: params[:report], name: :report
        div style: 'margin-top: 8px; text-align: center' do
          f.input :submit, type: :submit
        end
        div style: 'margin-top: 8px; text-align: center' do
          link_to 'CSV', admin_report_viewer_get_csv_path(params.to_enum.to_h), class: 'button'
        end
        div style: 'margin-top: 8px; text-align: center' do
          link_to 'Clear Cache', admin_report_viewer_clear_cache_path, class: 'button'
        end
      end
    end

    page_action :set_params, method: :post do
      redirect_to admin_report_viewer_path(params.to_enum.to_h)
    end

    page_action :get_csv, method: :get, format: :csv do
    end

    page_action :clear_cache, method: :get do
    end

    controller do
      def clear_cache
        ReportCache.all.each do |rc|
          rc.destroy
        end
        redirect_to admin_reports_path
      end

      def get_csv
        dates = view_context.set_dates
        @start_date = dates[0]
        @end_date = dates[1]
        report = "Reports::#{params[:report].camelize}".constantize.new(@start_date, @end_date, { params: params })
        @viewer, @title, @headers, @formats, @results, @chart = report.get

        csv_string = CSV.generate do |csv|
          @headers.each do |row|
            csv << row
          end
          @results.each do |row|
            csv << row
          end
        end
        send_data csv_string, filename: "#{@title.underscore}.csv", type: :csv, disposition: :attachment


      end
    end

  end
end
# rubocop:enable Metrics/BlockLength
