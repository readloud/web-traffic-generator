require 'openssl'
require 'base64'
require 'cgi'
require 'json'
require 'net/http'
require 'uri'

class Seomoz
  def process(limit = 100)
    return unless configured?
    urls(limit).each_slice(10) do |url_batch|
      authority = batch(url_batch)
      if authority.first.include?('pda')
        i = 0
        url_batch.each do |url|
          url.domain_authority  = authority[i]['pda']
          url.page_authority    = authority[i]['upa']
          url.save
          i += 1
        end
        say_not_in_prod "\tupdated"
      else
        say "\tnot updated: #{authority.to_s}"
      end
    end
  end

  protected

  def urls(limit)
    Url.where("domain_authority = '' OR domain_authority IS NULL").limit(limit)
  end

  def batch(batched_domains)
    domains = []
    batched_domains.each do |domain|
      domains << domain.url
    end
    say_not_in_prod "Processing batch: #{domains}"
    JSON.parse domain_metrics(domains)
  end

  def domain_metrics(batched_domains)
    encoded_domains = batched_domains.to_json
    uri             = URI.parse("#{request_url}")
    http            = Net::HTTP.new(uri.host, uri.port)
    request         = Net::HTTP::Post.new(uri.request_uri)
    request.body    = encoded_domains
    http.request(request).body
  end

  def request_url
    expires	            = Time.now.to_i + 300
    string_to_sign      = "#{access_id}\n#{expires}"
    binary_signature    = OpenSSL::HMAC.digest('sha1', secret_key, string_to_sign)
    url_safe_signature  = CGI::escape(Base64.encode64(binary_signature).chomp)
    cols                = '103079215108'
    "http://lsapi.seomoz.com/linkscape/url-metrics/?Cols=#{cols}&AccessID=#{access_id}&Expires=#{expires}&Signature=#{url_safe_signature}"
  end

  def configured?
    access_id && secret_key
  end

  def access_id
    ENV['SEOMOZ_ACCESS_ID']
  end

  def secret_key
    ENV['SEOMOZ_SECRET_KEY']
  end

  def say_not_in_prod(msg)
    if ENV['RAILS_ENV'] != 'production'
      say msg
    end
  end

  def say(msg)
    puts msg
  end
end