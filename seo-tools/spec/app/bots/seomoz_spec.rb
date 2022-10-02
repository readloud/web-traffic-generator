require 'spec_helper'

describe Seomoz do
  describe '#process' do

    let!(:url) do
      double('url', url: 'http://www.google.com', 'save' => true, 'domain_authority' => nil, 'domain_authority=' => nil, 'page_authority=' => nil)
    end
    let!(:seomoz_response) { [ { 'pda' => domain_authority, 'upa' => page_authority } ] }
    let!(:domain_authority) { 10 }
    let!(:page_authority) { 20 }

    before :each do
      subject.stub(:access_id).and_return( 'eee' )
      subject.stub(:secret_key).and_return( 'aa' )
      subject.stub(:batch).and_return(seomoz_response)
      subject.stub(:urls).and_return([ url ])
      subject.stub(:say)

      subject.process
    end

    describe 'given a valid response' do
      it 'should save domain authority' do
        expect(url).to have_received(:domain_authority=).with(domain_authority)
      end
      it 'should save page authority' do
        expect(url).to have_received(:page_authority=).with(page_authority)
      end
      it 'should save url' do
        expect(url).to have_received(:save)
      end
    end

    describe 'given an invalid response' do
      let!(:seomoz_response) { [ { 'error' => '503' } ] }
      it 'should save domain authority' do
        expect(url).to_not have_received(:domain_authority=)
      end
      it 'should save page authority' do
        expect(url).to_not have_received(:page_authority=)
      end
      it 'should save url' do
        expect(url).to_not have_received(:save)
      end
    end

  end
end