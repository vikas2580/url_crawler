FactoryBot.define do
  factory :page do
    sequence(:url) { |n| "https://example.com/page#{n}" }
    assets { ["asset1", "asset2"] }
    links { ["link1", "link2"] }
    crawled { true }
  end
end
