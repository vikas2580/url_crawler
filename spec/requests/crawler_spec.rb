require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "Crawlers", type: :request do
  before do
    stub_request(:post, "https://example.com").to_return(status: 200, body: "<html><body><a href='https://example.com/page1'>Page 1</a></body></html>")
    stub_request(:get, "https://example.com").to_return(status: 200, body: "<html><body></body></html>")
    stub_request(:get, "https://example.com/page1").to_return(status: 200, body: "<html><body><a href='https://example.com/page2'>Page 2</a></body></html>")
  end

  it 'should crawl a page and its assets' do
    post '/crawler', params: { url: 'https://example.com' }
    expect(response).to have_http_status(:success)

    get '/crawler'
    pages = JSON.parse(response.body)
    expect(pages.size).to eq(1)
  end
end
