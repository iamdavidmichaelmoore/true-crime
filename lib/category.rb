require_relative "./true_crime"


class Category
  attr_accessor :name
  attr_reader :documentaries

  @@all = []

  def initialize(name)
    @name = name
    @documentaries = []
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

  def self.create(name)
    category = self.new(name)
    category.save
    category
  end

  def find_by_name(name)
    self.all.detect {|category| category.name = name}
  end

  def find_or_create_by_name(name)
    find_by_name(name) || self.create(name)
  end

  def docs_count
    self.documentaries.count
  end
end
