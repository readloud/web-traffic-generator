require 'spec_helper'

describe Domains do
  describe '#process' do
    let!(:url) do
      url = Url.new
      url.url = 'http://www.supu.com/tamadre/?id=2'
      url.ip = '80.80.80.80'
      url.save
      url
    end
    let!(:domains_count) { Domain.all.count }
    let!(:subnets_count) { Subnet.all.count }

    before do
      subject.save_url_domain url
    end

    describe 'given a valid url without asigned domain' do
      it 'should create a new domain' do
        Domain.all.count.should_not be domains_count
      end
      it 'should relate url with new domain' do
        url.domain_id.should_not be nil
      end
      it 'should create a new subnet' do
        Subnet.all.count.should_not be subnets_count
      end
      it 'should create a valid subnet' do
        url.domain.subnet.ip.should.eql? '80.80.80'
      end
    end
  end
end