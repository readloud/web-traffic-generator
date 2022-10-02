require 'spec_helper'

describe DomainStatus do
  describe '#process' do
    let!(:links_amount) { 19 }
    let!(:link_status) { 'found' }
    let!(:links) do
      links = []
      links_amount.times do |round|
        link = Link.new
        link.url = urls.first
        link.affiliate = 'yes'
        link.status = link_status
        link.save
        links << link
      end
      links
    end

    let!(:url_amount) { 1 }
    let!(:urls) do
      urls = []
      url_amount.times do |round|
        url = Url.new
        url.url = "http://www.round#{round}.com"
        url.domain = domain
        url.save
        urls << url
      end
      urls
    end

    let!(:domain) do
      d = Domain.new
      d.url = 'name.com'
      d.status = status
      d.save
      d
    end

    let!(:affiliate_status) do
      s = Status.new
      s.name = 'affiliate'
      s.save
      s
    end

    before do
      subject.process_domain domain
    end

    describe 'given a valid domain with nil status' do
      let!(:status) { nil }
      describe 'and more than 5 affiliate links' do
        let!(:url_amount) { 1 }
        let!(:links_amount) { 19 }

        it 'should be saved as affiliate' do
          Domain.find(domain.id).status.should.eql? affiliate_status
        end
      end
      describe 'and less than 5 affiliate links' do
        let!(:url_amount)   { 1 }
        let!(:links_amount) { 2 }
        it 'should not be saved as affiliate' do
          Domain.find(domain.id).status.should.nil?
        end
      end
    end

    describe 'given a valid domain with affiliate status' do
      let!(:status) { affiliate_status }
      describe 'and more than 5 affiliate links' do
        let!(:url_amount) { 1 }
        let!(:links_amount) { 19 }

        it 'should be saved as affiliate' do
          Domain.find(domain.id).status.should.eql? affiliate_status
        end
      end
    end

    describe 'given a valid domain with other status' do
      let!(:status) do
        s = Status.new
        s.name = 'other'
        s.save
        s
      end

      describe 'and more than 5 affiliate links' do
        let!(:url_amount) { 1 }
        let!(:links_amount) { 19 }

        it 'should be saved as status' do
          Domain.find(domain.id).status.should.eql? status
        end
      end
    end

    describe 'given a valid domain with remove status' do
      let!(:status) do
        s = Status.new
        s.name = 'remove'
        s.save
        s
      end
      describe 'and all links are on status not found' do
        let!(:link_status) { 'link not found' }
        it 'should be saved as delete' do
          Domain.find(domain.id).status.name.should.eql? 'delete'
        end
      end
      describe 'and not all links are on status not found' do
        let!(:link_status) { 'found' }
        it 'should still remove status' do
          Domain.find(domain.id).status.should.eql? status
        end
      end
    end
  end
end
