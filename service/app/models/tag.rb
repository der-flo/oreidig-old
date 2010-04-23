class Tag < ActiveRecord::Base
  validates_length_of :name, :within => 1..100
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :links
  
  def to_json options = {}
    # TODO: Add "tag" node?
    {
      :id => id,
      :name => name,
      :usage_count => links.count
    }.to_json(options)
  end
end
