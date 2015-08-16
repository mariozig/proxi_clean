require 'faraday'
require 'json'

module ProxiClean
  class Client
    attr_reader :public_ip, :debug

    def initialize(debug=false)
      @debug = debug
      public_ip
    end

    def works?(proxy_uri)
      begin
        puts 'Checking: ' + proxy_uri if @debug
        proxied_ip = proxied_ip(proxy_uri)
      rescue StandardError => e
        puts 'ERROR: ' + e.message if @debug
        # If anything goes wrong, assuming the proxy is no good
        return false
      end

      public_ip != proxied_ip
    end

    def public_ip
      # Try to not hit realip more than we really need
      @public_ip ||= real_ip(proxy_uri: nil)
    end

    def proxied_ip(proxy_uri)
      real_ip(proxy_uri: proxy_uri)
    end

    private

    def real_ip(proxy_uri: nil)
      conn = Faraday.new(proxy: proxy_uri)
      conn.headers[:user_agent] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36'
      conn.headers[:accept] = 'application/json'
      response = conn.get do |req|
        req.url 'http://ipinfo.io'
        req.options.timeout = 8
        req.options.open_timeout = 5
      end
      JSON.parse(response.body)['ip']
    end
  end
end
