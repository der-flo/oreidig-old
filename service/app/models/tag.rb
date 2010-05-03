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
end
