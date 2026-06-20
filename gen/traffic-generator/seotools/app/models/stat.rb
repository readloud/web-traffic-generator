class Stat < ActiveRecord::Base
  belongs_to :status

  default_scope { order(day: :desc) }
  paginates_per 50

end
