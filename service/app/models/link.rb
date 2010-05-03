class Link < ActiveRecord::Base
  validates_length_of :url, :within => 1..500
  validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_length_of :title, :maximum => 250, :allow_nil => true
  validates_length_of :notes, :maximum => 5000, :allow_nil => true
  
  has_and_belongs_to_many :tags
  
  attr_accessible :url, :title, :notes, :tag_list
  
  def url= str
    str = "http://#{str}" unless /^\w+:\/\// =~ str or str.blank?
    self[:url] = str
  end
  
  def tag_list= list
    tags.clear
    list.split(',').each do |tag_name|
      tag_name.strip!
      tag = Tag.find_or_create_by_name(tag_name)
      tags << tag
    end
    
    # TODO: Destroy unlinked tags?
  end
  
  def tag_names
    tags.collect(&:name)
  end
  
  def to_json options = {}
    { :link => {
        :id => id,
        :title => title,
        :url => url,
        :notes => notes,
        :tags => tag_names
      }
    }.to_json(options)
  end
  
  def self.search query
    c = ['title LIKE ? OR url LIKE ? OR notes LIKE ?'] + ["%#{query}%"] * 3
    find :all, :conditions => c
  end
end
