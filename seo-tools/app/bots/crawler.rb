require 'open-uri'
require 'socket'

class Crawler
  include ActionView::Helpers::SanitizeHelper

  def process_links(url)
    verify_url url
    set_url_links_as_not_found url
    page = get_html url
    return unless page
    sites.each do |site|
      next if url.domain && url.domain.status && url.domain.status.name == 'OK'
      begin
        page_links_to_site(page, site).each do |link|
          save_link(url, site, link)
        end
        save_page_metrics(page, url, site)
      rescue
        puts "Could not fetch all the links for url: #{url.url}"
      end
    end
    save_domain_counters url
  end


  protected

  def save_link(url, site, link)
    link_path = link.attribute('href').to_s

    cmp = campaign link_path, site.campaign_id

    db_link = existing_link(link_path, url, site) || new_link
    db_link.site = site
    db_link.url = url
    db_link.link = link_path
    db_link.anchor = strip_tags link.children.to_s
    db_link.status = 'link found'
    db_link.campaign = cmp
    db_link.affiliate = affiliate? cmp

    db_link.save
  end

  def existing_link(link_path, url, site)
    Link.where(link: link_path, url: url, site: site).first
  end

  def new_link
    Link.new
  end

  ##
  # Get page for a given url
  #
  def get_html(url)
    begin
      return Nokogiri::HTML(open(url.url))
    rescue Exception
      puts "Could not open url: #{url.url}"
      return
    end
  end


  ##
  # Get all site related links on a page
  #
  def page_links_to_site(page, site)
    links = []
    page.css('a').each do |link|
      if are_same_domain(link.attribute('href').to_s, site.domain)
        links << link
      end
    end
    links
  end

  ##
  # Get site metrics
  #
  def save_page_metrics(page, url, site)
    page_domain = url.original_subdomain

    metrics = {internal_links: 0, external_links: 0}
    page.css('a').each do |link|
      link_href = link.attribute('href').to_s
      if is_internal_link(link_href, page_domain)
        metrics[:internal_links] += 1
      else
        metrics[:external_links] += 1
      end
    end
    update_url url, metrics
  end

  def is_internal_link(url, domain)
    are_same_domain(url, domain) or url.starts_with?('/')
  end

  def are_same_domain(url_string, domain)
    url = Url.new
    url.url = url_string
    url.original_subdomain == domain
  end

  def update_url(url, metrics)
    subdomain = url.original_subdomain
    url.subdomain = subdomain
    url.ip = IPSocket::getaddress subdomain
    url.internal_links = metrics[:internal_links]
    url.external_links = metrics[:external_links]
    url.visited_at = Time.now
    url.save
  end

  ##
  # Get all configured sites
  #
  def sites
    Site.all
  end

  ##
  # Get if url is for an affiliate or not
  #
  def affiliate?(campaign)
    return 'yes' if campaign
    'no'
  end


  ##
  # get the campaign parameter for a given url
  #
  def campaign(link, campaing_id)
    query = Rack::Utils.parse_query URI(link).query
    if query.include? campaing_id
      query[campaing_id]
    end
  end


  ##
  # Updates all url related links to status link not found
  #
  def set_url_links_as_not_found(url)
    if url.domain
      url.domain.links_counter = url.domain.links_counter - url.links.where(status: 'link found').count
    end
    url.links.update_all(status: 'link not found')
  end

  def save_domain_counters(url)
    return if url.domain.nil?
    url.domain.links_counter = url.domain.links_counter + url.links.where(status: 'link found').count
    url.domain.save
    save_subnet_links(url.domain.subnet) if url.domain.subnet
  end

  def verify_url(url)
    Domains.new.save_url_domain url
  end

  def save_subnet_links(subnet)
    count = 0
    subnet.domains.each do |domain|
      count = count + domain.links_counter
    end
    subnet.links_count = count
    subnet.domains_count = subnet.domains.count
    subnet.save
  end
end