class AddIndexToStateInReports < ActiveRecord::Migration[7.0]
  def change
    add_index :rp_reports, :state
  end
end
