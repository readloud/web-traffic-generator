class AddMetricsToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :internal_links, :integer, :default => 0
    add_column :urls, :external_links, :integer, :default => 0
  end
end
