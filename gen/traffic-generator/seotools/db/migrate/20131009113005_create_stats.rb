class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :site, index: true
      t.references :url, index: true
      t.string :internal_links
      t.string :external_links

      t.timestamps
    end
  end
end
