module Mailwizz
  module Endpoint

    ##
    # ListSegments handles all the API calls for handling the list segments.
    ##
    class ListSegments < Base

      ##
      # Get segments from a certain mail list
      # @param [String] list_uid
      # @param [Integer] page default 1
      # @param [Integer] per_page default 10
      # @return [excon/Response]
      def get_segments(list_uid, page = 1, per_page = 10)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('lists/%s/segments', list_uid)),
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