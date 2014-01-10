module Superbolt
  module Http
    class Adaptor
      attr_reader :uri

      def initialize uri
        @uri = uri
      end

      def get
        JSON.parse(
          RestClient.get escaped_uri
        )
      end

      def delete
        RestClient.delete escaped_uri
      end

      def escaped_uri
        URI.escape(uri)
      end
    end
  end
end