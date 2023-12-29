class CreateRpPendingReports < ActiveRecord::Migration[7.0]
  def change
    create_table :rp_pending_reports do |t|
      t.string   :broker_uuid, :limit => 500, :comment => "the uuid of the broker that will generate the file"
      t.datetime :created_at,  :comment => "the timestamp when this record was created"
      
      t.references :rp_reports
    end
  end
end
