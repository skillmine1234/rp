class CreateAuthorizedUsers < ActiveRecord::Migration[7.0]
  def change
    
    create_table :rp_authorized_users do |t|
      t.integer :available_report_id
      t.integer :user_id
    end
    
    add_index :rp_authorized_users, [:available_report_id, :user_id], unique: true
  end
end
