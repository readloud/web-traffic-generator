class Stats
  def process
    Status.all.each do |status|
      stat        = Stat.new
      stat.status = status
      stat.number = Domain.where(status: status).count
      stat.day    = Date.today
      stat.save
    end
  end
end