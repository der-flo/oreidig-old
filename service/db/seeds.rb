100.times do
  Link.create do |l|
    x = "http://#{Faker::Internet.domain_name}/#{Faker::Internet.domain_word}"
    l.url = x
    l.title = Faker::Lorem.sentence
    l.notes = Faker::Lorem.paragraphs.join "\n"
    l.tag_list = Faker::Lorem.words(rand(10)).uniq.join ', '
  end
end
