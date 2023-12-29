class ChangeIndexInReports < ActiveRecord::Migration[7.0]
  def change
    remove_index :rp_reports, :state
    add_index :rp_reports, [:state, :broker_uuid]
  end
end
