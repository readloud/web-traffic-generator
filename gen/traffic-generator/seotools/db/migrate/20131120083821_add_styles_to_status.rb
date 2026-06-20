class AddStylesToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :style, :string, default: ''
  end
end
