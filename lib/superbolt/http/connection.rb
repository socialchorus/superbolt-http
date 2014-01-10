module Superbolt
  module Http
    class Connection < OpenStruct
      extend Http

      def self.base_url
        "#{url}/api/connections"
      end

      def self.get_connections
        adaptor(base_url).get
      end

      def self.all
        get_connections.map do |connection|
          new connection
        end
      end

      def self.adaptor(uri)
        raise NoConnectionUrl unless url
        Adaptor.new(uri)
      end

      def delete
        begin
          self.class.adaptor(connection_uri).delete
        rescue Bunny::ConnectionForced => e
          warn "Connection Forced to Close"
        end
      end

      def connection_uri
        self.class.base_url + "/#{name}"
      end

      class NoConnectionUrl < StandardError; end
    end
  end
end