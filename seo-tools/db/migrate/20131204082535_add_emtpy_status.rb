class AddEmtpyStatus < ActiveRecord::Migration
  def up
    if Status.where(name: 'Empty').count == 0
      s = Status.new
      s.name = 'Empty'
      s.save
    end

    s = Status.where(name: 'Empty').first
    Domain.update_all "status_id = #{s.id}", "status_id IS NULL"
  end
end
