require_relative "./true_crime"


class Documentary

  attr_accessor :title, :year, :category, :synopsis, :synopsis_url

  @@all = []

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
    urls_array.each do |doc_attributes|
      documentary = self.new(doc_attributes)
      binding.pry
      documentary.category = Category.find_or_create_by_name(doc_attributes[:category])
      binding.pry
      documentary.save
    end
  end
  #this assumes that the category is already an object. why? how?
  def category=(category)
    @category = category
    category.documentaries << self unless category.documentaries.include?(self)
  end

  def self.docs_count
    self.all.count
  end
end
