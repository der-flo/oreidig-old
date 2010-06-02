require 'rubygems'
require 'ap'
require 'benchmark'
require 'json'
require 'enumerator'

include Benchmark

require 'methods'
################################################################################

################################################################################
$conn = start_connection

SOME_TAGS = %w(rails ruby gem plugin todo kvm ubuntu unix music games)

Benchmark.benchmark(" "*30 + CAPTION, 30, FMTSTR, "> total") do |b|
  ret = []

  ret << b.report('get tags') do
    fetch_tag_list
  end
  
  # # Assoziierte Tags
  # ret << b.report('get associated tags') do
  #   SOME_TAGS.each do |tag|
  #     fetch_associated_tags tag
  #   end
  # end
   
  # # Links anhand eines Tags holen
  # ret << b.report('get links by single tag') do
  #   10.times do
  #     SOME_TAGS[0..3].each do |tag|
  #       fetch_links_by_tags [tag]
  #     end
  #   end
  # end
  
  ret.inject {|sum, n| sum + n}
end

end_connection $conn
