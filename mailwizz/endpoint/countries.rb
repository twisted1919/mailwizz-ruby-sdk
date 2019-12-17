module Mailwizz
  module Endpoint

    ##
    # Countries handles all the API calls for handling the countries and their zones.
    ##
    class Countries < Base

      ##
      # Get all available countries
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def get_countries(page = 1, per_page = 10)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url('countries'),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end

      ##
      # Get all available country zones
      # @param [Integer] country_id
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def get_zones(country_id, page = 1, per_page = 10)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('countries/%d/zones', country_id)),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end
    end
  end
end