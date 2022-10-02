class DomainStatus

  # Processes an amount of domains
  def process(amount = nil)
    batch(amount).each do |domain|
      process_domain domain
    end
  end

  # Get a batch of domains for a given amount, or all of them
  def batch(amount = nil, filters = nil )
    filters |=  { status: default_statuses }
    batch_size = [amount.to_i, Domain.count].min
    if amount.nil?
      Domain.where(filters)
    else
      Domain.where(filters).limit(batch_size)
    end
  end

  def default_statuses
    statuses = []
    Status.where(name: [ 'Empty', 'remove' ]).each do |status|
      statuses << status.id
    end
    statuses
  end

  # Processes a domain
  def process_domain(domain)
    if domain.affiliate?
      domain.status = Status.where(name: 'affiliate').first
      domain.save
    elsif delete?(domain)
      domain.status = Status.where(name: 'remove').first
      domain.save
    end
  end

  def delete?(domain)
    domain.status && domain.status.name == 'remove' && domain.count_links_not_found == 0
  end

end