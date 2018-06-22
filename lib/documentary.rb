require_relative "./true_crime"


class Documentary

  attr_accessor :title, :year, :category, :synopsis, :synopsis_url

  @@all = []

  INDEX_PAGE_URL = "http://crimedocumentary.com"

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.create_documentary_from_collection(urls_array)
      urls_array.each do |attributes|
        documentary = self.new(attributes)
        documentary.category = Category.find_or_create_by_name(category)
        binding.pry
        documentary.category.documentaries << self unless documentary.category.documentaries.include?(self)
      end
    binding.pry
  end

  def category=(category)
    @category = category
  end

  def categories
    @categories.uniq
  end

  def self.docs_count
    self.all.count
  end
end
