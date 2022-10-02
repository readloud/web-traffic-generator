require 'spec_helper'

describe Url do
  describe '#original_domain' do
    let!(:subdomain) { '' }
    let!(:high_level_domain) { 'com' }
    let!(:url) { "http://#{subdomain}supu.#{high_level_domain}" }

    before do
      subject.url = url
    end

    describe 'for domains' do
      describe 'one word domain' do
        it 'should return one word domain' do
          subject.original_domain.should eq 'supu.com'
        end
      end
      describe 'two words domain' do
        let!(:high_level_domain) { 'com.es' }
        it 'should return two words domain' do
          subject.original_domain.should eq 'supu.com.es'
        end
      end
      describe 'dash separated domains' do
        let!(:url) { 'http://www.hello-world.com/abcde' }
        it 'should return the domain hello-world.com' do
          subject.original_domain.should eq 'hello-world.com'
        end
      end
    end

    describe 'for sub-domains' do
      let!(:subdomain) { 'www.' }
      describe 'one word domain' do
        it 'should return one word domain' do
          subject.original_domain.should eq 'supu.com'
        end
      end
      describe 'two words domain' do
        let!(:high_level_domain) { 'com.es' }
        it 'should return two words domain' do
          subject.original_domain.should eq 'supu.com.es'
        end
      end
    end

    describe 'for sub-domains' do
      let!(:subdomain) { 'tupu.tamadre.' }
      describe 'one word domain' do
        it 'should return one word domain' do
          subject.original_domain.should eq 'supu.com'
        end
      end
      describe 'two words domain' do
        let!(:high_level_domain) { 'com.es' }
        it 'should return two words domain' do
          subject.original_domain.should eq 'supu.com.es'
        end
      end
    end

  end
end