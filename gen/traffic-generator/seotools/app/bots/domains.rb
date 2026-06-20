class Domains

  def process(amount)
    batch_size = [amount.to_i, Url.count].min
    Url.where(:domain_id => nil).limit(batch_size).each do |url|
      say "Fetching domain for #{url.url}"
      save_url_domain(url)
    end
  end

  def save_url_domain(url)
    return if url.nil?
    # TODO This is temporary removed, please uncomment
    # return unless url.domain.nil?
    return if url.original_domain == ''

    url.domain = domain_for url
    url.save
    url
  end

  # Get the related domain for a url
  def domain_for(url)
    domain = Domain.where(:url => url.original_domain).first
    domain ||= Domain.new :url=> url.original_domain
    domain.subnet = subnet_for url
    domain.save
    domain
  end

  # Output a message
  def say(message)
    if ENV['RAILS_ENV'] != 'production'
      puts message
    end
  end

  # Get / create a subnet for a given url
  def subnet_for(url)
    return unless url.ip
    ip = url.ip.split('.')[0..2].join('.')
    net = Subnet.where(ip: ip).first
    unless net
      net = Subnet.new
      net.ip = ip
      net.save
    end
    net
  end

end





