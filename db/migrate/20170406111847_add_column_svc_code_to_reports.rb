class AddColumnSvcCodeToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_available_reports, :service_code, :string, limit: 100, default: 'RP', comment: 'the service code for this report'
    add_column :rp_reports, :service_code, :string, limit: 100, comment: 'the service code for this report'
    add_column :rp_pending_reports, :service_code, :string, limit: 100, comment: 'the service code for this pending report'
  end
end
