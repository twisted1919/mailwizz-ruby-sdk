module Mailwizz
  module Endpoint

    ##
    # Customers handles all the API calls for customers.
    ##
    class Customers < Base

      ##
      # Create a new customer
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def create(data)
        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url('customers'),
                                'params_post': __prepare_body(data)
                            })
        client.request
      end

      protected

      ##
      # Prepare the body of the request
      # @param [Hash] data
      # @return [Hash]
      ##
      def __prepare_body(data)
        data[:customer][:confirm_password] = data[:customer][:password]
        data[:customer][:confirm_email] = data[:customer][:email]

        timezone = data[:customer][:timezone]
        if timezone.empty?
          data[:customer][:timezone] = 'UTC'
        end

        data
      end
    end
  end
end
