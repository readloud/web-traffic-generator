require 'addressable/uri'
require 'domainatrix'

class Url < ActiveRecord::Base
  belongs_to :domain
  has_many :links
  has_many :stats

  validates_uniqueness_of :url

  default_scope { order(id: :asc) }

  paginates_per 50

  def original_subdomain
    return '' if invalid_url?
    url = "http://#{self.url}" if URI.parse(self.url).scheme.nil?
    return URI.parse(self.url).host.downcase
  rescue Exception
    return ''
  end

  def original_domain
    return '' if invalid_url?
    uri = Domainatrix.parse(url)
    "#{uri.domain}.#{uri.public_suffix}"
  rescue Exception
    return ''
  end

  def invalid_url?
    return true if url.empty?
    return true if url.starts_with?('/') or url.starts_with?('#')
    return true unless url=~ URI::regexp
    return true if url.starts_with?('mailto:')
    return true if url.starts_with?('javascript:')
  end

end
