class RenameColumnRpReportsIdInPendingReports < ActiveRecord::Migration[7.0]
  def change
    rename_column :rp_pending_reports, :rp_reports_id, :report_id
  end
end
