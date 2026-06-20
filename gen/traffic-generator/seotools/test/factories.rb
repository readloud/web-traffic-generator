FactoryGirl.define do

  factory :status do
    name 'OK'
    style 'btn-success'
  end

  factory :domain do
    sequence(:url) do |n|
      "google#{n}.com"
    end
    association :status, factory: :status
  end

  factory :url do
    sequence(:url) do |n|
      "http://www.google.com?s=#{n}"
    end
    visited_at Date.new(2000, 1, 1)
    association :domain, factory: :domain
  end

  factory :site do
    sequence(:code) do |n|
      "site#{n}"
    end
    sequence(:domain) do |n|
      "www.site#{n}.com"
    end
    campaign_id 'cid'
  end
end