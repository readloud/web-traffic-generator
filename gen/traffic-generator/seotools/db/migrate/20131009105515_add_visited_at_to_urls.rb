class AddVisitedAtToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :visited_at, :datetime
  end
end
