module Mailwizz
  module Endpoint

    ##
    # Templates handles all the API calls for email templates.
    ##
    class Templates < Base

      ##
      # Get all the email templates of the current customer
      #
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def get_templates(page = 1, per_page = 10)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url('templates'),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end

      ##
      # Search through all the email templates of the current customer
      #
      # @param [Integer] page
      # @param [Integer] per_page
      # @param [Hash] filters
      # @return [excon/Response]
      ##
      def search_templates(page = 1, per_page = 10, filters = nil)
        if filters.nil?
          filters = {}
        end

        params_get = {
            'page': page,
            'per_page': per_page,
            'filter': filters
        }

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url('templates'),
                                'params_get': Base.encode(params_get)
                            })
        client.request
      end

      ##
      # Get one template
      #
      # @param [String] template_uid
      # @return [excon/Response]
      ##
      def get_template(template_uid)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('templates/%s', template_uid)),
                                'params_get': {}
                            })
        client.request
      end

      ##
      # Create a new template
      #
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def create(data)
        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url('templates'),
                                'params_post': __prepare_body(data)
                            })
        client.request
      end

      ##
      # Update one template
      # 
      # @param [String] template_uid
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def update(template_uid, data)
        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url(sprintf('templates/%s', template_uid)),
                                'params_put': __prepare_body(data)
                            })
        client.request
      end

      ##
      # Delete one template
      # 
      # @param [String] template_uid
      # @return [excon/Response]
      ##
      def delete(template_uid)
        client = Client.new({
                                'method': Client::METHOD_DELETE,
                                'url': Base.config.api_url(sprintf('templates/%s', template_uid)),
                            })
        client.request
      end

      ##
      # Prepare the body of the request
      # @param [Hash] data
      # @return [String]
      ##
      def __prepare_body(data)

        prepared_data = {}
        prepared_data[:template] = data

        if prepared_data[:template].has_key?(:content)
          unless prepared_data[:template][:content].empty?
            prepared_data[:template][:content] = Base64.encode64(prepared_data[:template][:content])
          end
        end

        if prepared_data[:template].has_key?(:archive)
          unless prepared_data[:template][:archive].empty?
            prepared_data[:template][:archive] = Base64.encode64(prepared_data[:template][:archive])
          end
        end

        prepared_data
      end
    end
  end
end