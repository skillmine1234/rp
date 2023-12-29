module Rp
  module AvailableReportsHelper
    def find_available_reports(records, params)
      reln = records.where(service_code: params[:service_code]).order(:name)
      reln = reln = reln.where("lower(name) like lower('#{params[:report_name]}%')") if params[:report_name].present?
      reln
    end
  end
end