class ChangeColumnsInSettings < ActiveRecord::Migration[7.0]
  def change
    change_column :rp_settings, :scheme, :string, null: false
    Rp::Setting.update_all(max_age_days: 7, max_per_user: 7)
    change_column :rp_settings, :max_age_days, :integer, null: false, default: 7
    change_column :rp_settings, :max_per_user, :integer, null: false, default: 7
  end
end
