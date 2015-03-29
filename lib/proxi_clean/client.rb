require 'rest_client'

module ProxiClean
  class Client
    attr_reader :public_ip

    def initialize
      public_ip
    end

    def works?(proxy_uri)
      begin
        proxied_ip = proxied_ip(proxy_uri)
        puts "proxied_ip is #{proxied_ip}"
      rescue StandardError => e
        # Assume the proxy doesn't work if anything goes wrong
        return false
      end

      public_ip != proxied_ip
    end

    def public_ip
      RestClient.proxy = nil
      @public_ip ||= result_from_real_ip_api
    end

    private

    def proxied_ip(proxy_uri)
      RestClient.proxy = proxy_uri
      result_from_real_ip_api
    end

    def result_from_real_ip_api
      real_up_url = 'http://www.realip.info/api/p/realip.php'
      JSON.parse(RestClient.get(real_up_url))['IP']
    end
  end
end
