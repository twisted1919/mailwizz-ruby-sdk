module Mailwizz
  module Endpoint

    ##
    # TransactionalEmails handles all the API calls for transactional emails.
    ##
    class TransactionalEmails < Base

      ##
      # Get all transactional emails of the current customer
      #
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def get_emails(page = 1, per_page = 10)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url('transactional-emails'),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end

      ##
      # Get one email
      # 
      # @param [String] email_uid
      # @return [excon/Response]
      ##
      def get_email(email_uid)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('transactional-emails/%s', email_uid)),
                                'params_get': {}
                            })
        client.request
      end

      ##
      # Create a new email
      #
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def create(data)
        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url('transactional-emails'),
                                'params_post': __prepare_body(data)
                            })
        client.request
      end

      ##
      # Delete one email
      # 
      # @param [String] email_uid
      # @return [excon/Response]
      ##
      def delete(email_uid)
        client = Client.new({
                                'method': Client::METHOD_DELETE,
                                'url': Base.config.api_url(sprintf('transactional-emails/%s', email_uid)),
                            })
        client.request
      end

      ####
      # Prepare the body of the request
      # @param [Hash] data
      # @return [String]
      ##
      def __prepare_body(data)

        prepared_data = {}
        prepared_data[:email] = data

        if prepared_data[:email].has_key?(:body)
          unless prepared_data[:email][:body].empty?
            prepared_data[:email][:body] = Base64.encode64(prepared_data[:email][:body])
          end
        end

        if prepared_data[:email].has_key?(:plain_text)
          unless prepared_data[:email][:plain_text].empty?
            prepared_data[:email][:plain_text] = Base64.encode64(prepared_data[:email][:plain_text])
          end
        end

        prepared_data
      end
    end
  end
end