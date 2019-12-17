module Mailwizz
  module Endpoint

    ##
    # CampaignBounces handles all the API calls for campaigns bounces.
    ##
    class CampaignBounces < Base

      ##
      # Get bounces from a certain campaign
      #
      # @param [String] campaign_uid
      # @param [Integer] page
      # @param [Integer] per_page
      #
      # @return [excon/Response]
      def get_bounces(campaign_uid, page = 1, per_page = 10)
        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('campaigns/%s/bounces', campaign_uid)),
                                'params_get': {
                                    'page': page,
                                    'per_page': per_page
                                }
                            })
        client.request
      end

      ##
      # Create a new bounce in the given campaign
      #
      # @param [String] campaign_uid
      # @param [Hash] data
      #
      # @return [excon/Response]
      def create(campaign_uid, data)
        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url(sprintf('campaigns/%s/bounces', campaign_uid)),
                                'params_post': data
                            })
        client.request
      end
    end
  end
end