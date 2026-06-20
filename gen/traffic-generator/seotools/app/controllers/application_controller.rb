class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate
  skip_before_filter :authenticate, :only => [:oauth2callback]

  attr_accessor :__auth_client__

  def authenticate
    if ['production', 'development'].include? Rails.env
      if session[:profile].nil?
        redirect_to auth_url
      end
    end
  end

  def oauth2callback
    url_to_redirect = root_path
    oauth = auth_client.auth_code.get_token(params[:code], { :redirect_uri => redirect_uri, :token_method => :post })
    if oauth
      user = profile(oauth)
      if valid_user? user
        session[:profile]  = user
        url_to_redirect = urls_path
      else
        flash[:auth_error] = "Seo-tool only allows access to accounts from #{valid_domains.join(', ')} domain."
      end
    end
    redirect_to url_to_redirect
  end

  def sign_out
    session[:profile] = nil
    redirect_to root_path
  end

  def auth_client
    @__auth_client__ ||= OAuth2::Client.new(client_id,
                                            client_secret,
                                            { :site           => 'https://accounts.google.com',
                                              :authorize_url  => "/o/oauth2/auth",
                                              :token_url      => "/o/oauth2/token" })
  end

  def auth_url
    auth_client.auth_code.authorize_url(:scope              => scope,
                                        :access_type        => 'offline',
                                        :redirect_uri       => redirect_uri,
                                        :approval_prompt    => 'force')
  end

  def profile(oauth)
    @__profile__ ||= JSON.parse oauth.get("https://www.googleapis.com/oauth2/v1/userinfo?alt=json").body
  end

  def client_id
    ENV['OAUTH_ID']
  end

  def client_secret
    ENV['OAUTH_SECRET']
  end

  def redirect_uri
    "#{request.base_url}/oauth2callback"
  end

  def scope
    'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile'
  end

  def valid_user?(user)
    valid_domains.include? user['email'].split('@').last
  end

  def valid_domains
    ENV['OAUTH_VALID_DOMAIN'].split(',').map(&:strip)
  end

end
