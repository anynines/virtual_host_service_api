class ChangeVHostCertDatatypes < ActiveRecord::Migration[7.0]
  def change
    change_column :v_hosts, :ssl_certificate, :text
    change_column :v_hosts, :ssl_ca_certificate, :text
    change_column :v_hosts, :ssl_key, :text
  end
end
