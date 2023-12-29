class AddIndexOnBrokerUuidInPendingReports < ActiveRecord::Migration[7.0]
  def change
    add_index :rp_pending_reports, :broker_uuid
  end
end
