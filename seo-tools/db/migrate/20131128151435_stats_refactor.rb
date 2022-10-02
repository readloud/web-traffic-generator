class StatsRefactor < ActiveRecord::Migration
  def up
    remove_column :stats, :site_id
    remove_column :stats, :url_id
    remove_column :stats, :internal_links
    remove_column :stats, :external_links


    add_reference :stats, :status, index: true
    add_column :stats, :day, :string
    add_column :stats, :number, :integer, default: 0
  end

  def down
    remove_column :stats, :status_id
    remove_column :stats, :day
    remove_column :stats, :number

    add_reference :stats, :site
    add_reference :stats, :url
    add_column :stats, :internal_links, :integer
    add_column :stats, :external_links, :integer
  end
end
