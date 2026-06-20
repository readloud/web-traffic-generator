class Site < ActiveRecord::Base
  has_many :links
  has_many :stats

  def to_s
    code
  end
end
