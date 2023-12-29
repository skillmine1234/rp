class AddColumnCodeToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_available_reports, :code, :string, limit: 50, comment: 'the unique code for this report'
    Rp::AvailableReport.all.each do |ar|
      ar.update_attributes(code: "RP#{ar.id}")
    end
    change_column :rp_available_reports, :code, :string, null: false
    add_index :rp_available_reports, :code, unique: true, name: 'rp_available_reports_01'
  end
end
