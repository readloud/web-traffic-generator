class Domain < ActiveRecord::Base
  belongs_to :status
  belongs_to :subnet
  has_many :urls

  after_initialize :init

  default_scope { order(links_counter: :desc) }
  paginates_per 50

  def init
    self.status ||= Status.where(name: 'Empty').first
  end

  def to_s
    url
  end

  def affiliate?
    if status.nil? || status.empty?
      if affiliates_count > minimum_affiliate_count
        true
      else
        false
      end
    elsif status.affiliate?
      true
    else
      false
    end
  end

  def count_links_not_found
    Url.joins(:links).where(domain_id: id, 'links.status' => 'link not found').count
  end

  def affiliates_count
    Url.joins(:links).where('links.affiliate' => 'yes', domain: self).count
  end

  def minimum_affiliate_count
    5
  end

end
