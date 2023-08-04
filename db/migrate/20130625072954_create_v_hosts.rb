class CreateVHosts < ActiveRecord::Migration[7.0]
  def change
    create_table :v_hosts do |t|
      t.string :ssl_certificate
      t.string :ssl_ca_certificate
      t.string :ssl_key
      t.string :server_name
      t.string :server_aliases
      
      t.string :organization_guid

      t.timestamps
    end
  end
end
