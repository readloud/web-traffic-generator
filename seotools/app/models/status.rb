class Status < ActiveRecord::Base
  def to_s
    name
  end

  def empty?
    name == 'Empty'
  end

  def affiliate?
    name == 'affiliate'
  end
end
