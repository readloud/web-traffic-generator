class DefaultStatusRemove < ActiveRecord::Migration
  def change
    if Status.where(name: 'remove').count == 0
      s = Status.new
      s.name = 'remove'
      s.save
    end

    if Status.where(name: 'delete').count == 0
      s = Status.new
      s.name = 'delete'
      s.save
    end
  end
end
