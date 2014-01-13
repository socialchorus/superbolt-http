module Superbolt
  module Http
    class Adaptor
      attr_reader :uri

      def initialize uri
        @uri = uri
      end

      def get
        JSON.parse(
          RestClient.get uri
        )
      end

      def delete
        begin
          RestClient.delete uri
         rescue RestClient::InternalServerError => e
        end
      end
    end
  end
end