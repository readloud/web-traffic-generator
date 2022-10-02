class AddServerDetailsToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :ip, :string
    add_column :urls, :domain, :string
    add_column :urls, :subdomain, :string
  end
end
