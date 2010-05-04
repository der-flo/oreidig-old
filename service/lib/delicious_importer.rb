require 'net/http'
require 'net/https'
require 'crack/xml'
module DeliciousImporter

  Entry = Struct.new(:href, :title, :extended, :tags, :time)
  CONF_FILE = Rails.root.join('config', 'delicious.yml')
  CONF = YAML.load(File.read(CONF_FILE)).symbolize_keys

  def self.fetch_all_entries
    http = Net::HTTP.new('api.del.icio.us', 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    xml = http.start do |http|
        req = Net::HTTP::Get.new('/v1/posts/all',
                                 'User-Agent' => 'oreidig-importer')
        req.basic_auth(CONF[:username], CONF[:password])
        http.request(req).body
    end
    data = Crack::XML.parse(xml)
    data['posts']['post'].collect do |p|
      tags = p['tag'].split(' ').join(',')
      # TODO: &amp; von crack überprüfen
      Entry.new(p['href'], p['description'], p['extended'], tags,
                Time.parse(p['time']))
    end
  end

  def self.import
    entries = fetch_all_entries
    entries.each do |entry|
      # begin
        link = Link.new(:title => entry.title[0, 250], :url => entry.href,
                        :notes => entry.extended, :tag_list => entry.tags)
        link.created_at = entry.time
        link.updated_at = entry.time
        link.save!
      # rescue ActiveRecord::RecordInvalid
      #   puts link.to_yaml
      # end
    end
    nil
  end
end
