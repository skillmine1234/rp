class AddColumnIsPublicToAvailableReports < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_available_reports, :is_public, :string, default: 'Y', comment: 'the identifier which indicates whether the report is publically accessible or not'
  end
end
