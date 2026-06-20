class CreateDefaultStatus < ActiveRecord::Migration
  def change
    if Status.where(name: 'affiliate').count == 0
      s = Status.new
      s.name = 'affiliate'
      s.save
    end
    if Status.where(name: 'OK').count == 0
      s = Status.new
      s.name = 'OK'
      s.save
    end
  end
end
