class AddMozMetricsToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :domain_authority, :string
    add_column :urls, :page_authority, :string
    add_column :urls, :source, :string
  end
end
