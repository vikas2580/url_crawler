require 'open-uri'
require 'nokogiri'

class CrawlerController < ApplicationController
  before_action :set_page, only: [:show, :update, :destroy]

  def index
    @pages = Page.all
    render json: @pages
  end

  def create
    url = params[:url]
    crawl_page(url)
    render json: { message: 'Crawling completed successfully' }
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def crawl_page(url)
  return if Page.find_by(url: url)

  begin
    html = open(url)
    rescue OpenURI::HTTPRedirect => redirect
      url = redirect.uri.to_s
      retry
    rescue OpenURI::HTTPError => e
      Rails.logger.error "Failed to open URL: #{url}. Error: #{e.message}"
      return
  end

    doc = Nokogiri::HTML(html)
    assets = doc.css('link[href], script[src], img[src]').map { |element| element['src'] || element['href'] }
    links = doc.css('a').map { |a| a['href'] }
    page = Page.create(url: url, assets: assets, links: links, crawled: true)

    links.each do |link|
      next if link.nil? || link.start_with?('mailto:', 'tel:', '#', 'javascript:')

      absolute_link = URI.join(url, link).to_s
      crawl_page(absolute_link) unless Page.find_by(url: absolute_link)
    end
  end
end
