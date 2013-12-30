module Superbolt
  module Http
    class Connection < OpenStruct
      class << self 
        attr_accessor :url
      end

      def self.all
        raise NoConnectionUrl unless url
        rest_client_get(base_url).map do |conn|
          new conn
        end
      end

      def self.get(name)
        raise NoConnectionUrl unless url
        new rest_client_get(base_url + "/#{name}")
      end

      def self.delete(name)
        raise NoConnectionUrl unless url
        rest_client_delete(base_url + "/#{name}")
      end


      private

      def self.base_url
        "#{url}/api/connections"
      end

      def self.rest_client_get(uri)
        JSON.parse(
          RestClient.get(URI.escape(uri))
        )
      end

      def self.rest_client_delete(uri)
        RestClient.delete URI.escape(uri)
      end

      class NoConnectionUrl < StandardError; end
    end
  end
end