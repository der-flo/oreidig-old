class Link < ActiveRecord::Base
  validates_length_of :url, :within => 1..500
  validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https file ftp))
  validates_length_of :title, :maximum => 250, :allow_nil => true
  validates_length_of :notes, :maximum => 5000, :allow_nil => true
  
  # TODO: title kann in der DB nicht NULL sein
  
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
  
  def has_tags? tagz
    tag_idz = tagz.collect do |tag|
      begin
        tag_id = Tag.find_by_name!(tag).id
      rescue ActiveRecord::RecordNotFound
        return false
      end
    end
    
    tag_ids & tag_idz == tag_idz
  end
  
  def self.find_all_by_tags tagz
    
    if tagz.length == 1
      Tag.find_by_name!(tagz.first).links
    else
      tag_idz = tagz.collect do |tag|
        begin
          tag_id = Tag.find_by_name!(tag).id
        rescue ActiveRecord::RecordNotFound
          return false
        end
      end

      sql = %Q{
        SELECT link_id, COUNT(*)
        FROM links_tags
        WHERE tag_id IN (#{tag_idz.join(',')})
        GROUP BY link_id
        HAVING COUNT(*) = #{tag_idz.length}
      }
      link_ids = connection.execute(sql).collect { |line| line[0] }
      find(link_ids)
    end
  end
end
