class AddColumnQueryTimeoutToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_settings, :query_timeout, :integer, default: 60, comment: 'the query timeout interval for the report'
  end
end
