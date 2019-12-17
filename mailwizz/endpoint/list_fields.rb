module Mailwizz
  module Endpoint

    ##
    # ListFields handles all the API calls for handling the list custom fields.
    ##
    class ListFields < Base

      ##
      # Get fields from a certain mail list
      # @param [String] list_uid
      # @return [excon/Response]
      ##
      def get_fields(list_uid)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('lists/%s/fields', list_uid)),
                                'params_get': {}
                            })
        client.request
      end
    end
  end
end