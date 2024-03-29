class RemoveColumns < ActiveRecord::Migration
  def self.up
    remove_column :urls, :domain
  end

  def self.down
    add_column :urls, :domain, :string
  end
end
