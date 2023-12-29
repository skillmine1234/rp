class CreateRpReports < ActiveRecord::Migration[7.0]
  def change
    create_table :rp_reports do |t|
      t.string :name, null: false, comment: 'the name of the report'
      t.string :state, length: 50, null: false, comment: 'the state of the report'
      t.datetime :queued_at, null: false, comment: 'the timestamp when the report was queued'
      t.string :mime_type, comment: 'the mime type of the file'
      t.string :created_by, length: 20, comment: 'the person who created the report'
      t.string :report_url, comment: 'the complete url of the show page of this report, to include in the notification email'
      t.string :notify_to, comment: 'the email address to which notifications are sent, when asked'
      t.string :dsn, comment: 'the jdbc data source where the report should be run'
      t.string :db_unit, comment: 'the package that will return the result set of the report'
      t.string :batch_size, comment: 'the batch size for the report'
      t.string :msg_model, comment: 'the dfdl message model'
      t.string :file_ext, comment: 'the file extension for the report'

      t.datetime :started_at, comment: 'the timestamp when the report generation started'
      t.datetime :finished_at, comment: 'the timestamp when the report generation completed'
      t.integer :line_count, comment: 'the no of lines in the report'
      t.integer :size_in_bytes, comment: 'the file size in bytes'
      t.string :file_name, comment: 'the name of the output file'
      t.string :file_path, comment: 'the path of the output file'
      t.string :fault_code, length: 50, comment: 'the fault code, in case the generation fails'
      t.string :fault_subcode, length: 50, comment: 'the detail fault code, in case the generation fails'
      t.string :fault_reason, length: 1000, comment: 'the english text for the fault, in case the generation fails'
      t.text :fault_bitstream, comment: 'the fault exception trace, if one exists'      
    end
  end
end
