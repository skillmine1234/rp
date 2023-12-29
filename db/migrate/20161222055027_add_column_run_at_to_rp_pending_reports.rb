class AddColumnRunAtToRpPendingReports < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_pending_reports, :run_at, :datetime, comment: 'the scheduled time for the report to get generated'
  end
end
