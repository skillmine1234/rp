class CreateRpSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :rp_settings do |t|
      t.string :scheme, comment: 'the scheme, file, scp or http(s)'
      t.string :host, comment: 'the host or host:port where the file is placed, could be name or ip'
      t.string :username, comment: 'the user, optional'
      t.string :password, comment: 'the password, optional'
      t.string :virtual_path, comment: 'the web url, used for the http(s) protocol'
    end
  end
end
