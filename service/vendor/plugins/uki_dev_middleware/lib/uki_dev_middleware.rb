require "net/http"

#Friendly ripped from Rack::Proxy

class UkiDevMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    uri = URI.parse("http://localhost:21119#{req.path}")
    sub_request = Net::HTTP::Get.new "#{uri.path}"

    begin
      sub_response = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(sub_request)
      end
    rescue Errno::ECONNREFUSED
      warn "Warning: Uki server seems not to be running"
    end

    return @app.call(env) if sub_response.nil? or sub_response.code.to_i != 200

    headers = {}
    sub_response.each_header do |k,v|
      headers[k] = v unless k.to_s =~ /content-length|transfer-encoding/i
    end

    [sub_response.code.to_i, headers, [sub_response.read_body]]
  end
end