module Mailwizz
  module Endpoint

    ##
    # Lists handles all the API calls for lists.
    ##
    class Lists < Base

      ##
      # Get all the mail list of the current customer
      #
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def get_lists(page = 1, per_page = 10)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url('lists'),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end

      ##
      # Get one list
      # 
      # @param [String] list_uid
      # @return [excon/Response]
      ##
      def get_list(list_uid)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('lists/%s', list_uid)),
                                'params_get': {}
                            })
        client.request
      end

      ##
      # Create a new mail list for the customer
      # The data param must contain following keys:
      #     -> general
      #     -> defaults
      #     -> notifications
      #     -> company
      #
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def create(data)
        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url('lists'),
                                'params_post': data
                            })
        client.request
      end

      ##
      # Update one list
      #
      # @param [String] list_uid
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def update(list_uid, data)
        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url(sprintf('lists/%s', list_uid)),
                                'params_put': data
                            })
        client.request
      end

      ##
      # Copy one list
      # 
      # @param [String] list_uid
      # @return [excon/Response]
      ##
      def copy(list_uid)
        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url(sprintf('lists/%s/copy', list_uid)),
                            })
        client.request
      end

      ##
      # Delete one list
      # 
      # @param [String] list_uid
      # @return [excon/Response]
      ##
      def delete(list_uid)
        client = Client.new({
                                'method': Client::METHOD_DELETE,
                                'url': Base.config.api_url(sprintf('lists/%s', list_uid)),
                            })
        client.request
      end
    end
  end
end