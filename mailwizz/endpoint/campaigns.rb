module Mailwizz
  module Endpoint
    require "base64"

    ##
    # Campaigns handles all the API calls for campaigns.
    ##
    class Campaigns < Base

      ##
      # Get all the campaigns of the current customer
      # @param [Integer] page
      # @param [Integer] per_page
      # @return [excon/Response]
      ##
      def get_campaigns(page = 1, per_page = 10)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url('campaigns'),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end

      ##
      # Get one campaign
      # @param [String] campaign_uid
      # @return [excon/Response]
      ##
      def get_campaign(campaign_uid)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('campaigns/%s', campaign_uid)),
                            })
        client.request
      end

      ##
      # Create a new campaign
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def create(data)

        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url('campaigns'),
                                'params_post': __prepare_body(data)
                            })
        client.request
      end

      ##
      # Update one campaign
      # @param [String] campaign_uid
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def update(campaign_uid, data)

        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url(sprintf('campaigns/%s', campaign_uid)),
                                'params_put': __prepare_body(data)
                            })
        client.request
      end

      ##
      # Copy one campaign
      # @param [String] campaign_uid
      # @return [excon/Response]
      ##
      def copy(campaign_uid)

        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url(sprintf('campaigns/%s/copy', campaign_uid)),
                            })
        client.request
      end

      ##
      # Pause/Unpause a campaign
      # @param [String] campaign_uid
      # @return [excon/Response]
      ##
      def pause_unpause(campaign_uid)

        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url(sprintf('campaigns/%s/pause-unpause', campaign_uid)),
                            })
        client.request
      end

      ##
      # Mark a campaign as sent
      # @param [String] campaign_uid
      # @return [excon/Response]
      ##
      def mark_sent(campaign_uid)

        client = Client.new({
                                'method': Client::METHOD_PUT,
                                'url': Base.config.api_url(sprintf('campaigns/%s/mark-sent', campaign_uid)),
                            })
        client.request
      end

      ##
      # Delete a campaign
      # @param [String] campaign_uid
      # @return [excon/Response]
      ##
      def delete(campaign_uid)

        client = Client.new({
                                'method': Client::METHOD_DELETE,
                                'url': Base.config.api_url(sprintf('campaigns/%s', campaign_uid)),
                            })
        client.request
      end

      protected

      ##
      # Prepare the body of the request
      # @param [Hash] data
      # @return [String]
      ##
      def __prepare_body(data)

        if data[:template].has_key?(:content)
          unless data[:template][:content].empty?
            data[:template][:content] = Base64.encode64(data[:template][:content])
          end
        end

        if data[:template].has_key?(:archive)
          unless data[:template][:archive].empty?
            data[:template][:archive] = Base64.encode64(data[:template][:archive])
          end
        end

        if data[:template].has_key?(:plain_text)
          unless data[:template][:plain_text].empty?
            data[:template][:plain_text] = Base64.encode64(data[:template][:plain_text])
          end
        end

        campaign_data = {}
        campaign_data[:campaign] = data

        campaign_data
      end
    end
  end
end