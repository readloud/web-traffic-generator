class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :url, index: true
      t.references :site, index: true
      t.string :link
      t.string :anchor
      t.string :status
      t.string :affiliate
      t.string :campaign

      t.timestamps
    end
  end
end
