module Mailwizz
  module Endpoint

    ##
    # CampaignsTracking handles all the API calls for campaigns tracking.
    ##
    class CampaignsTracking < Base

      ##
      # Track campaign url click for certain subscriber
      #
      # @param [String] campaign_uid
      # @param [String] subscriber_uid
      # @param [String] hash_string
      # @return [excon/Response]
      ##
      def track_url(campaign_uid, subscriber_uid, hash_string)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('campaigns/%s/track-url/%s/%s', campaign_uid, subscriber_uid, hash_string)),
                                'params_get': {}
                            })
        client.request
      end

      ##
      # Track campaign url click for certain subscriber
      # @param [String] campaign_uid
      # @param [String] subscriber_uid
      # @return [excon/Response]
      ##
      def track_opening(campaign_uid, subscriber_uid)

        client = Client.new({
                                'method': Client::METHOD_GET,
                                'url': Base.config.api_url(sprintf('campaigns/%s/track-opening/%s', campaign_uid, subscriber_uid)),
                                'params_get': {}
                            })
        client.request
      end

      ##
      # Track campaign unsubscribe for certain subscriber
      # @param [String] campaign_uid
      # @param [String] subscriber_uid
      # @param [Hash] data
      # @return [excon/Response]
      ##
      def track_unsubscribe(campaign_uid, subscriber_uid, data)

        client = Client.new({
                                'method': Client::METHOD_POST,
                                'url': Base.config.api_url(sprintf('campaigns/%s/track-unsubscribe/%s', campaign_uid, subscriber_uid)),
                                'params_post': data
                            })
        client.request
      end
    end
  end
end