require 'test_helper'

class CrawlerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get crawler_index_url
    assert_response :success
  end

  test "should get create" do
    get crawler_create_url
    assert_response :success
  end

end
