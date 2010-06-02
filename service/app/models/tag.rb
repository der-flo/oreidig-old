class Tag < ActiveRecord::Base
  validates_length_of :name, :within => 1..100
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :links
  
  def to_json options = {}
    { :tag =>{
        :name => name,
        :usage_count => usage_count
      }
    }.to_json(options)
  end
  
  def usage_count
    links.count
  end
  
  def to_param
    name
  end

  def self.search query
    find :all, :conditions => ['name LIKE ?', "%#{query}%"]
  end
  
  def associated
    tagz = Hash.new(0)
    links.find(:all, :include => :tags).each do |link|
      link.tags.each do |tag|
        tagz[tag] += 1
      end
    end
    tagz.delete(self)
    tagz
  end
  
  def associated_as_json
    associated.collect do |tag, count|
      { :tag => { :name => tag.name, :usage_count => count } }
    end
  end
end
