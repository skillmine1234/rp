require_dependency "rp/application_controller"

module Rp
  class ReportsController < ApplicationController
    before_action :set_report, only: [:destroy, :retry]

    # GET /reports
    def index
      reports = policy_scope(Rp::Report).where(service_code: 'RP').order('id desc')
      @reports = reports.paginate(per_page: 10, page: params[:page])
    end

    def ft
      reports = policy_scope(Rp::Report).where(service_code: 'FT').order('id desc')
      paginate_reports(reports)
    end

    def ic
      reports = policy_scope(Rp::Report).where(service_code: 'IC').order('id desc')
      paginate_reports(reports)
    end
    
    def ft_system_generated_reports
      reports = Rp::Report.where(service_code: 'FT', created_by: nil).order('id desc')
      paginate_reports(reports)
    end
    
    def su
      reports = policy_scope(Rp::Report).where(service_code: 'SU').order('id desc')
      paginate_reports(reports)
    end
    
    def imt
      reports = policy_scope(Rp::Report).where(service_code: 'IMT').order('id desc')
      paginate_reports(reports)
    end
    
    def cc
      reports = policy_scope(Rp::Report).where(service_code: 'CC').order('id desc')
      paginate_reports(reports)
    end
    
    def gm
      reports = policy_scope(Rp::Report).where(service_code: 'GEM').order('id desc')
      paginate_reports(reports)
    end

    # POST /reports
    def create
      @report = Report.new(report_params)
    
      if @report.save   
        if @report.service_code == 'FT'
          redirect_to ft_reports_path, notice: 'Report was successfully created.'
        elsif @report.service_code == 'IC'
          redirect_to ic_reports_path, notice: 'Report was successfully created.'
        elsif @report.service_code == 'SU'
          redirect_to su_reports_path, notice: 'Report was successfully created.'
        elsif @report.service_code == 'IMT'
          redirect_to imt_reports_path, notice: 'Report was successfully created.'
        elsif @report.service_code == 'CC'
          redirect_to cc_reports_path, notice: 'Report was successfully created.'
        elsif @report.service_code == 'GEM'
          redirect_to gm_reports_path, notice: 'Report was successfully created.'
        else
          redirect_to reports_path, notice: 'Report was successfully created.'
        end
      else
        redirect_to :back, notice: @report.errors.full_messages
      end
    end

    def show
      @report = Report.find(params[:id])
      respond_to do |format|
        format.js
      end      
    end

    def download
      require 'uri'
      require 'uri/open-scp'
      report = Report.find(params[:id])
      
      authorize report

      begin
        uri = URI(report.file_url)
        if uri.scheme == Rp::Setting::FILE_SCHEMES[:scp]
          download_file(report)
        elsif uri.scheme == Rp::Setting::FILE_SCHEMES[:file]
          send_file uri.path, filename: report.file_name, type: report.mime_type
        else
          raise "Not Implemented"
        end
      rescue StandardError => e
        redirect_to :back, notice: e.message
      end
    end

    def show_fault
      report = Report.find(params[:id])
      @fault = report # report responds to fault
      respond_to do |format|
        format.js
      end
    end
    
    def retry
      @report.create_pending_report
      redirect_to :back
    end

    private
    
      def paginate_reports(reports)
        @reports = reports.paginate(per_page: 10, page: params[:page])
        render 'index'
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_report
        @report = Report.find(params[:id])
      end
      
      def download_file(report)
        open("#{report.file_url}") do |file|
          begin
            file_content = file.read
            tempfile = Tempfile.new(report.file_name, encoding: file_content.encoding).tap do |f|
              f.write(file_content)
              f.close
            end
            send_file tempfile.path, filename: report.file_name, type: report.mime_type
          ensure
            tempfile.close
          end
        end
      end

      # Only allow a trusted parameter "white list" through.
      def report_params
        
        params.permit(:available_report_id, 
        :param1_name, :param1_type, :param1_value,
        :param2_name, :param2_type, :param2_value, 
        :param3_name, :param3_type, :param3_value, 
        :param4_name, :param4_type, :param4_value, 
        :param5_name, :param5_type, :param5_value)
        .merge(created_by: try(:current_user).try(:id) || '',
               protocol: request.protocol, 
               host: request.host_with_port)
      end
  end
end
