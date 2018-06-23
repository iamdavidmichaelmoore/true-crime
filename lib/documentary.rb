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

  def self.create_documentary_from_collection(attributes_hash_array)
    attributes_hash_array.each do |attributes|
      documentary = self.new(attributes)
      category = Category.find_or_create_by_name(attributes[:category])
      documentary.category = category
      unless category.documentaries.include?(documentary)
        category.documentaries << documentary
      end
    end
  end

  def self.alphabetical
    self.all.sort_by {|documentary| documentary.title}
  end

  # def self.alpha_lister(char)
  #   self.all.find_all {|documentary| documentary.title.upcase.start_with?(char.upcase)}
  # end

  def self.docs_count
    self.all.count
  end
end
