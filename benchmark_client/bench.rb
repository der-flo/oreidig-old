require 'rubygems'
require 'ap'
require 'benchmark'
require 'json'
require 'enumerator'

include Benchmark

require 'methods'
################################################################################
$conn = start_connection

SOME_TAGS = %w(rails ruby gem plugin todo kvm ubuntu unix music games)

Benchmark.benchmark(" "*30 + CAPTION, 30, FMTSTR, "> total") do |b|
  ret = []
  
  # TODO: 100* Tag-Liste holen
  ret << b.report('get tags') do
    fetch_tag_list
  end
  
  # 10*10* Tag holen
  ret << b.report('get tag') do
    10.times do
      SOME_TAGS.each do |tag|
        fetch_tag tag
      end
    end
  end
  
  # Assoziierte Tags
  ret << b.report('get associated tags') do
    SOME_TAGS.each do |tag|
      fetch_associated_tags tag
    end
  end
  
  ret << b.report('post, put, delete link') do
    10.times do
      # Link erstellen
      id = create_link

      # Link bearbeiten
      edit_link id

      # Link löschen
      delete_link id
    end
  end
  
  # Tag bearbeiten
  ret << b.report('put tag') do
    10.times do
      SOME_TAGS.each do |tag|
        tag2 = "#{tag}___xxx"
        edit_tag tag, tag2
        edit_tag tag2, tag
      end
    end
  end
  
  # Links anhand eines Tags holen
  ret << b.report('get links by single tag') do
    10.times do
      SOME_TAGS[0..3].each do |tag|
        fetch_links_by_tags [tag]
      end
    end
  end

  # Links anhand mehreren Tags holen
  ret << b.report('get links by multiple tags') do
    10.times do
      SOME_TAGS[0..3].each_slice(2) do |tags|
        fetch_links_by_tags tags
      end
    end
  end
  
  ret.inject {|sum, n| sum + n}
end

end_connection $conn
################################################################################

# get tags                        0.030000   0.040000   0.070000 ( 18.489631)
# get tag                         0.170000   0.100000   0.270000 ( 13.889348)
# get associated tags             0.050000   0.050000   0.100000 ( 23.988655)
# post, put, delete link          0.060000   0.030000   0.090000 (  4.639233)
# put tag                         0.400000   0.230000   0.630000 ( 24.359870)
# get links by single tag         1.120000   0.820000   1.940000 (217.147782)
# get links by multiple tags      0.150000   0.090000   0.240000 ( 22.958773)
