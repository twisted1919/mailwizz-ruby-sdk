module Mailwizz

  ##
  # This file contains the base class for the Mailwizz Python-SDK.
  # Base is the base class for all the other classes used in the sdk.
  ##
  class Base

    ##
    # Config the configuration object injected into the application at runtime
    # It is declared as a static attribute
    ##
    class << self
      attr_accessor :config
    end

    ##
    # Getter for the config object
    ##
    def self.config
      @config
    end

    ##
    # Setter for the config object
    # @param [Config] config
    ## 
    def self.config=(config)
      @config = config
    end
    
    ##
    # Right strip string helper method
    ##
    # @param [String] string
    # @param [String] substitute
    #
    # @return [String]
    ##
    def self.rstrip(string, substitute)
      string.gsub(/['#{substitute}']+$/, '')
    end
    
    ##
    # Url encoder method for a multidimensional Hash
    # @param [Mixed] value
    # @param [String] key
    # @param [Hash] out_hash
    # 
    # @return [Hash]
    ##
    def self.encode(value, key = nil, out_hash = {})
      case value
      when Hash then
        value.each {|k, v| encode(v, append_key(key, k), out_hash)}
        out_hash
      when Array then
        value.each_with_index {|v, index| encode(v, "#{key}[#{index}]", out_hash)}
        out_hash
      when nil then
        ''
      else
        out_hash[key] = value
        out_hash
      end
    end


    ##
    # Sort multidimensional hash by key
    # 
    # @param [Hash] hash
    # @param [Boolean] recursive
    # @param [Hash] block
    #
    # @return [Hash]
    ## 
    def self.sort_by_key(hash, recursive = false, &block)
      hash.keys.sort(&block).reduce({}) do |seed, key|
        seed[key] = hash[key]
        if recursive && seed[key].is_a?(Hash)
          seed[key] = sort_by_key(seed[key], true, &block)
        end
        seed
      end
    end


    private

    def self.append_key(root_key, key)
      root_key.nil? ? :"#{key}" : :"#{root_key}[#{key.to_s}]"
    end


    protected

    ##
    # Method used to prepare the body of the data sent to the API
    # 
    # @param [Hash] data
    #
    # @return [String]
    ##
    def __prepare_body(data)
      URI.encode_www_form(Base.encode(data))
    end
  end
end