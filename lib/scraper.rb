require_relative "./true_crime"
require 'open-uri'
require 'pry'

class TrueCrimeScraper


  def self.scrape_categories(index_page_url)
    categories_array = []
    index_page = Nokogiri::HTML(open(index_page_url))
    index_page.css("div.g1-column-inner #text-5 ul li").each_with_index do |category, num|
      categories_array << category.text
    end
    categories_array
  end

  def self.scrape_urls(index_page_url)
    docs_urls = []
    index_page = Nokogiri::HTML(open(index_page_url))
    index_page.css("div.g1-column-inner #text-5 ul li").each_with_index do |category, num|
      docs_urls << index_page.css("div.g1-column-inner #text-5 ul li a")[num]["href"]
    end
    docs_urls
  end

  def self.scrape_documentary_attributes(path)
    attr_array = []
    category_page = Nokogiri::HTML(open(path))
    category_page.css("figure.entry-featured-media").each_with_index do |documentary, num|
      attr_hash = {}
      attr_hash[:title] = category_page.css("h3.g1-delta.entry-title a")[num].text.gsub(/^?[( ]\d{4}[) ]/, " ").strip
      attr_hash[:year] = category_page.css("h3.g1-delta.entry-title a")[num].text.scan(/^?\d{4}/).last
      attr_hash[:category] = category_page.css("h1.g1-beta.g1-beta-2nd.archive-title").text
      attr_hash[:synopsis] = category_page.css("div.entry-body.g1-current-background div.entry-summary.g1-text-narrow p")[num].text
      attr_hash[:synopsis_url] = category_page.css("figure.entry-featured-media a")[num]["href"]
      attr_array << attr_hash
    end
    attr_array
  end

  # alternate method to scrape data per user selection
  # def self.scrape_documentary_attributes(category_url, num)
  #   category_page = Nokogiri::HTML(open(category_url))
  #   category_page.css("figure.entry-featured-media")[num]
  #   hash = {}
  #   hash[:title] = category_page.css("h3.g1-delta.entry-title a")[num].text.gsub(/^?[( ]\d{4}[) ]/, " ").strip
  #   hash[:year] = category_page.css("h3.g1-delta.entry-title a")[num].text.scan(/^?\d{4}/).last
  #   hash[:category] = category_page.css("h1.g1-beta.g1-beta-2nd.archive-title").text
  #   hash[:synopsis] = category_page.css("div.entry-body.g1-current-background div.entry-summary.g1-text-narrow p")[num].text
  #   hash[:synopsis_url] = category_page.css("figure.entry-featured-media a")[num]["href"]
  #   documentary_attributes << hash
  # end
end
