class AddFileUrlToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :rp_reports, :file_url, :string, comment: 'the file url as per the configured scheme'
  end
end
