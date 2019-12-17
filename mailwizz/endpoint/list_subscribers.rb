module Mailwizz
  module Endpoint
    require 'json'

    ##
    # ListSubscribers handles all the API calls for lists subscribers.
    ##
    class ListSubscribers < Base

      ##
      # Get subscribers from a certain mail list
      #
      # @param [String] list_uid
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def get_subscribers(list_uid, page = 1, per_page = 10)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers', list_uid)),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end

      ##
      # Get one subscriber from a certain mail list
      # 
      # @param [String] list_uid
      # @param [String] subscriber_uid
      # @return [excon/Response]
      ##
      def get_subscriber(list_uid, subscriber_uid)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/%s', list_uid, subscriber_uid)),
                                'params_get': {}
                            })
        client.request
      end

      ##
      # Create a new subscriber in the given list
      #
      # @param [String] list_uid
      # @param [String] data
      # @return [excon/Response]
      ##
      def create(list_uid, data)

        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/', list_uid)),
                                'params_post': data
                            })
        client.request
      end

      ##
      # Create subscribers in bulk in the given list
      # This feature is available since  1.8.1
      #
      # @param [String] list_uid
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def create_bulk(list_uid, data)

        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/bulk', list_uid)),
                                'params_post': __prepare_body(data)
                            })
        client.request
      end

      ##
      # Update existing subscriber in given list
      #
      # @param [String] list_uid
      # @param [String] subscriber_uid
      # @param [Hash]
      #
      # @return [excon/Response]
      ##
      def update(list_uid, subscriber_uid, data)

        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/%s', list_uid, subscriber_uid)),
                                'params_put': data
                            })
        client.request
      end

      ##
      # Unsubscribe existing subscriber from given list
      # 
      # @param [String] list_uid
      # @param [String] subscriber_uid
      # @return [excon/Response]
      ##
      def unsubscribe(list_uid, subscriber_uid)

        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/%s/unsubscribe', list_uid, subscriber_uid)),
                            })
        client.request
      end

      ##
      # Unsubscribe existing subscriber by email address
      #
      # @param [String] list_uid
      # @param [String] email_address
      # @return [excon/Response]
      ##
      def unsubscribe_by_email(list_uid, email_address)

        response = email_search(list_uid, email_address)

        if response.nil?
          return response
        end

        content = JSON.parse(response.body)

        if content['status'] == 'error' || content['data'].empty?
          return response
        end


        if content['data']['subscriber_uid'].empty?
          return response
        end

        unsubscribe(list_uid, content['data']['subscriber_uid'])
      end

      ##
      # Unsubscribe existing subscriber by email address from all lists
      #
      # @param [String] email_address
      # @return [excon/Response]
      ##
      def unsubscribe_by_email_from_all_lists(email_address)

        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url('lists/subscribers/unsubscribe-by-email-from-all-lists'),
                                'params_put': {
                                    'EMAIL': email_address
                                }
                            })
        client.request
      end

      ##
      # Delete existing subscriber from given list
      #
      # @param [String] list_uid
      # @param [String] subscriber_uid
      # @return [excon/Response]
      ##
      def delete(list_uid, subscriber_uid)

        client = Client.new({
                                'method': Client::METHOD_DELETE,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/%s', list_uid, subscriber_uid)),
                                'params_delete': {}
                            })
        client.request
      end

      ##
      # Delete existing subscriber by email address
      #
      # @param [String] list_uid
      # @param [String] email_address
      # @return [excon/Response]
      ##
      def delete_by_email(list_uid, email_address)

        response = email_search(list_uid, email_address)
        content = JSON.parse(response.body)


        if content.has_key?('status') && content['status'] == 'error'
          return response
        end

        if content.has_key?('data') && content['data'].has_key?('subscriber_uid')
          unless content['data']['subscriber_uid'].empty?
            return delete(list_uid, content['data']['subscriber_uid'])
          end
        end

        response
      end

      ##
      # Search in a list for given subscriber by email address
      #
      # @param [String] list_uid
      # @param [String] email_address
      # @return [excon/Response]
      ##
      def email_search(list_uid, email_address)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/search-by-email', list_uid)),
                                'params_get': {
                                    'EMAIL': email_address
                                }
                            })
        client.request
      end

      ##
      # Search in a all lists for given subscriber by email address
      # Please note that this is available only for mailwizz >= 1.3.6.2
      #
      # @param [String] email_address
      # @return [excon/Response]
      ##
      def email_search_all_lists(email_address)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url('lists/subscribers/search-by-email-in-all-lists'),
                                'params_get': {
                                    'EMAIL': email_address
                                }
                            })
        client.request
      end

      ##
      # Search in a list by custom fields
      #
      # @param [String] list_uid
      # @param [String] fields
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def search_by_custom_fields(list_uid, fields, page = 1, per_page = 10)

        params_get = fields
        params_get[page] = page
        params_get[per_page] = per_page

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('lists/%s/subscribers/search-by-custom-fields', list_uid)),
                                'params_get': params_get
                            })
        client.request
      end

      ##
      # Create or update a subscriber in given list
      #
      # @param [String] list_uid
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def create_update(list_uid, data)

        email_address = nil
        if data.has_key?(:EMAIL)
          email_address = data[:EMAIL]
        end

        response = email_search(list_uid, email_address)
        content = JSON.parse(response.body)

        if content.has_key?('status') && content['status'] == 'error'
          return create(list_uid, data)
        end

        if content.has_key?('data') && content['data'].has_key?('subscriber_uid')
          unless content['data']['subscriber_uid'].empty?
            return update(list_uid, content['data']['subscriber_uid'], data)
          end
        end

        response
      end


      protected

      ##
      # Prepare the body of the request
      # @param [Hash] data
      # @return [String]
      ##
      def __prepare_body(data)
        prepared_data = {
            :subscribers => []
        }

        data.each do |val|
          prepared_data[:subscribers].push(val)
        end

        prepared_data
      end
    end
  end
end