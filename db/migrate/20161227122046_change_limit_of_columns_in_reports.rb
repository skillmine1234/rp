class ChangeLimitOfColumnsInReports < ActiveRecord::Migration[7.0]
  def change
    change_column :rp_reports, :name, :string, limit: 100
    change_column :rp_reports, :state, :string, limit: 50
    change_column :rp_reports, :fault_code, :string, limit: 50
    change_column :rp_reports, :fault_subcode, :string, limit: 50
    change_column :rp_reports, :fault_reason, :string, limit: 1000
    change_column :rp_reports, :created_by, :string, limit: 20
  end
end
