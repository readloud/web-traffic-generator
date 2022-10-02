class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.references :status, index: true
      t.string :url

      t.timestamps
    end
  end
end
