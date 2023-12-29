class AddColumnNormalizeSpace < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_available_reports, :normalize_space, :string, limit: 1, default: 'Y', comment: 'the flag which indicates whether we want to normalize space for all columns in the report'
    add_column :rp_reports, :normalize_space, :string, limit: 1, default: 'Y', comment: 'the flag which indicates whether we want to normalize space for all columns in the report'
  end
end
