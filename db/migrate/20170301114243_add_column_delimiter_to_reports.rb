class AddColumnDelimiterToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_available_reports, :delimiter, :string, limit: 1, default: ',', comment: 'the delimiter for the rows in the output file'
    add_column :rp_reports, :delimiter, :string, limit: 1, default: ',', comment: 'the delimiter for the rows in the output file'
    add_column :rp_available_reports, :escape_character, :string, limit: 1, default: '"', comment: 'the escape character for the output file'
    add_column :rp_reports, :escape_character, :string, limit: 1, default: '"', comment: 'the escape character for the output file'
  end
end
