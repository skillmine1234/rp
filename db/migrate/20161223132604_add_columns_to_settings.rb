class AddColumnsToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_settings, :max_age_days, :integer, comment: 'the max number of days a report will be available'
    add_column :rp_settings, :max_per_user, :integer, comment: 'the max number of reports for a user at any given time'
  end
end
