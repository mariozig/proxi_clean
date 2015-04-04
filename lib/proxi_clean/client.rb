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
      rescue StandardError => e
        # If anything goes wrong, assuming the proxy is no good
        return false
      end

      public_ip != proxied_ip
    end

    def public_ip
      RestClient.proxy = nil
      # Try to not hit realip more than we really need
      @public_ip ||= result_from_real_ip_api
    end

    private

    def proxied_ip(proxy_uri)
      RestClient.proxy = proxy_uri
      result_from_real_ip_api
    end

    def result_from_real_ip_api
      real_up_url = 'http://www.realip.info/api/p/realip.php'
      response = RestClient::Request.execute(method: :get,
                                             url: real_up_url,
                                             read_timeout: 10,
                                             open_timeout: 10)
      JSON.parse(response)['IP']
    end
  end
end
