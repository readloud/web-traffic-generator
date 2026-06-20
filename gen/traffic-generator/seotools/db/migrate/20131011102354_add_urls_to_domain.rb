class AddUrlsToDomain < ActiveRecord::Migration
  def change
    add_reference :urls, :domain, index: true
  end
end
