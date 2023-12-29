class ChangeColumnsToMandatoryInAvailableReports < ActiveRecord::Migration[7.0]
  def change
    Rp::AvailableReport.where(dsn: nil).update_all(dsn: 'a')
    Rp::AvailableReport.where(db_unit: nil).update_all(db_unit: 'a')
    change_column :rp_available_reports, :dsn, :string, null: false
    change_column :rp_available_reports, :db_unit, :string, null: false
    remove_column :rp_available_reports, :batch_size, :string
    add_column :rp_available_reports, :batch_size, :integer, null: false, default: 50, comment: 'the batch size for the report'
  end
end
