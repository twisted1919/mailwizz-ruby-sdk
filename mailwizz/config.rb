module Mailwizz
  require 'uri'

  ##
  # Config contains the configuration class that is injected at runtime into the main application.
  # It's only purpose is to set the needed data so that the API calls will run without problems.
  ##
  class Config < Base
    attr_accessor :public_key
    attr_accessor :private_key
    attr_accessor :charset

    def initialize(config = {})
      if config.nil?
        raise 'Please define the API connection attributes'
      end

      self.api_url = config.has_key?(:api_url) ? config[:api_url] : nil
      @public_key = config.has_key?(:public_key) ? config[:public_key] : nil
      @private_key = config.has_key?(:private_key) ? config[:private_key] : nil

    end

    ##
    # Getter for the api_url
    # @param [String] endpoint
    ##
    def api_url(endpoint = nil)
      if @api_url.nil?
        raise 'Please set the api base url.'
      end

      @api_url + (endpoint || '')
    end

    ##
    # Setter for the api_url
    # @param [String] url
    ##
    def api_url=(url)
      if !url =~ URI::regexp
        raise 'Please set a valid api base url'
      end

      @api_url = Base.rstrip(url, '/') + '/'
    end
  end
end
