require 'http'

$default_headers = {
  'Accept' => 'application/json',
  'Content-Type' => 'application/json'
}

# Zuerst mit generischem HTTP-Client

# Simplen REST-Client selbst bauen

# TODO: Zuerst seriell, dann parallel

def enc str
  URI::encode str
end

def fetch_tag_list
  response, body = $conn.get('/tags', $default_headers)
end

def fetch_tag tag
  response, body = $conn.get("/tags/#{enc tag}", $default_headers)
end

def edit_tag old_name, new_name
  tag = {
    :tag => {
      :name => enc(new_name)
    }
  }
  response, body = $conn.put("/tags/#{enc old_name}", tag.to_json,
                             $default_headers)
end

def create_link
  link = {
    :link => {
      :url => 'http://www.google27.de',
      :title => 'Google',
      :notes => 'x'*200,
      :tag_list => 'test, test2'
    }
  }
  response, body = $conn.post('/links', link.to_json, $default_headers)
  id = JSON.parse(body)['link']['id'].to_i
  id
end

def edit_link id
  link = {
    :link => {
      :title => 'Google edit'
    }
  }
  response, body = $conn.put("/links/#{id}", link.to_json, $default_headers)
end

def delete_link id
  response, body = $conn.delete("/links/#{id}", $default_headers)
end

def fetch_links_by_tags tags
  t = enc(tags.join(','))
  response, body = $conn.get("/links?tags=#{t}", $default_headers)
end

def fetch_associated_tags tag
  response, body = $conn.get("/tags/#{enc tag}/associated", $default_headers)
end
