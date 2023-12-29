class AddUniqueIndexOnPendingReports < ActiveRecord::Migration[7.0]
  def change
    add_index :rp_pending_reports, :report_id, unique: true
  end
end
