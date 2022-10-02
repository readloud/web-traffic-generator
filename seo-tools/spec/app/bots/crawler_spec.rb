require 'spec_helper'

describe Crawler do
  describe '#process_links' do

    let!(:links)        { double('links', update_all: true, where: links_count) }
    let!(:links_count)  { double('links_count', count: 10) }
    let!(:fake_domain)  { 'http://www.domain.com/blabla' }
    let!(:page)         { double('page', css: [ link ]) }
    let!(:site)         { double('site', domain: 'www.domain.com', campaign_id: nil )}
    let!(:children)     { 'anchor' }
    let!(:link)         { double('link', attribute: fake_domain, children: children, empty?: false) }
    let!(:sites)        { [site] }
    let!(:url) do
      double('url',
             links: links,
             url: 'http://www.google.com',
             visited_at: nil,
             save: true,
             domain: domain,
             original_subdomain: 'www.google.com',
             'internal_links=' => nil,
             'external_links=' => nil,
             'visited_at=' => nil,
             'ip=' => nil,
             'domain=' => nil,
             'subdomain=' => nil,
             'domain_authority=' => nil,
             'page_authority=' => nil)
    end
    let!(:domain) do
      double('domain',
             url: 'google.com',
             status: status,
             links_counter: 10,
             'links_counter='=> 10,
             save: true,
             subnet: nil)
    end
    let!(:status) { double('status', name: 'noOK') }
    let!(:db_link) do
      double('Link', 'site=' => '', 'url=' => '', 'link=' => '', 'anchor=' => '', 'status=' => '',
             'campaign=' => '', 'affiliate=' => '', 'save' => '')
    end

    before :each do
      subject.stub(:sites).and_return(sites)
      subject.stub(:get_html).and_return(page)
      subject.stub(:existing_link).and_return(nil)
      subject.stub(:new_link).and_return(db_link)
      subject.stub(:verify_url).and_return(url)

      subject.process_links(url)
    end

    describe 'given a valid url' do
      it 'should open the remote url' do
        subject.should have_received(:get_html).with(url)
      end
      it 'should look for all anchors in the page' do
        page.should have_received(:css).twice.with('a')
      end
      it 'should update all the links status to not found' do
        links.should have_received(:update_all).with(status: 'link not found')
      end
      it 'should save all found links' do
        db_link.should have_received(:save)
      end
      it 'should save metrics on url' do
        url.should have_received(:save)
      end
      it 'should save the domain before starting anything' do
        subject.should have_received(:verify_url).with url
      end
    end

  end
end