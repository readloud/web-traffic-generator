require 'spec_helper'


describe ApplicationController, :type => :controller do
  let!(:auth_client)    { double('client', auth_code: auth_code) }
  let!(:auth_code)      { double('code', get_token: token, authorize_url: authorize_url) }
  let!(:token)          { double('token', get: token_get) }
  let!(:token_get)      { double('token_get', body: token_body) }
  let!(:email)          { 'test@kodify.io' }
  let!(:profile)        { { email: email } }
  let!(:token_body)     { JSON.generate(profile, quirks_mode: true) }
  let!(:authorize_url)  { 'http://www.google.com' }

  describe 'GET oauth2callback' do
    before(:each) do
      ENV.stub(:[]).with('OAUTH_ID').and_return('')
      ENV.stub(:[]).with('OAUTH_SECRET').and_return('')
      ENV.stub(:[]).with('OAUTH_VALID_DOMAIN').and_return('kodify.io')
      OAuth2::Client.any_instance.stub(auth_code: auth_code)
      request.session[:profile] = nil
      get :oauth2callback
    end

    describe 'log in with valid user' do
      it { response.should redirect_to urls_path }
      it 'should store profile in session' do
        request.session[:profile].should.equal? profile
      end
    end

    describe 'log in with invalid user' do
      let!(:token) { nil }

      it { response.should redirect_to root_path }
      it { should_not set_the_flash }
    end

    describe 'log in with not permitted user' do
      let!(:email) { 'test@invalid.io' }

      it { response.should redirect_to root_path }
      it { should set_the_flash[:auth_error].to "Seo-tool only allows access to accounts from #{subject.valid_domains.join(', ')} domain." }
    end
  end
end
