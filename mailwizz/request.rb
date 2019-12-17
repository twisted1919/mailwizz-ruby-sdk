module Mailwizz
  require 'uri'
  require 'rubygems'
  require 'excon'
  require 'openssl'

  ##
  # Request is the request class used to send the requests to the API endpoints.
  ##
  class Request < Base

    # The client object
    attr_accessor :client

    # The request params
    attr_accessor :params

    def initialize(client)
      @client = client
    end

    def send
      get_params = @client.params_get
      request_url = Base.rstrip(@client.url, '/')
      query_string = ''

      if get_params
        sorted_get_params = Base.sort_by_key(get_params, true) {|x, y| x.to_s <=> y.to_s}
        query_string = URI.encode_www_form(Base.encode(sorted_get_params))
      end

      if query_string
        request_url += '?' + query_string
      end

      _sign(request_url)

      if @client.put_method? || @client.delete_method?
        @client.add_header({'X-HTTP-Method-Override' => @client.method.upcase})
      end

      _make_request
    end

    private

    def _make_request
      connection = Excon.new(@client.url)

      if @client.get_method?
        return connection.get(
            :query => @client.params_get,
            :headers => @client.headers,
            :connect_timeout => @client.timeout
        )
      end

      if @client.post_method?
        @client.add_header({"Content-Type" => "application/x-www-form-urlencoded"})
        return connection.post(
            :body => __prepare_body(@client.params_post),
            :headers => @client.headers,
            :connect_timeout => @client.timeout
        )
      end

      if @client.put_method?
        return connection.put(
            :body => __prepare_body(@client.params_put),
            :headers => @client.headers,
            :connect_timeout => @client.timeout
        )
      end

      if @client.delete_method?
        connection.delete(
            :body => __prepare_body(@client.params_delete),
            :headers => @client.headers,
            :connect_timeout => @client.timeout
        )
      end
    end

    private

    ##
    # TODO - Implement the signature
    def _sign(request_url)
      config = Base.config
      public_key = config.public_key
      private_key = config.private_key
      timestamp = Time.now.to_i

      remote_addr = ENV['REMOTE_ADDR'].nil? ? '82.77.82.161' : ENV['REMOTE_ADDR']

      headers = {
          'X-MW-PUBLIC-KEY': public_key,
          'X-MW-REMOTE-ADDR': remote_addr,
          'X-MW-TIMESTAMP': timestamp,
      }
      @client.add_header(headers)

      params = headers

      params.merge!(@client.params_post).merge!(@client.params_put).merge!(@client.params_delete)

      sorted_params = Base.sort_by_key(params, true) {|x, y| x.to_s.downcase <=> y.to_s}

      separator = '?'
      if request_url.include? "?"
        if @client.params_get.empty?
          separator = ''
        else
          separator = '&'
        end
      end

      signature_string = @client.method.upcase + ' ' + request_url + separator + URI.encode_www_form(Base.encode(sorted_params))

      hmac = OpenSSL::HMAC.hexdigest('sha1', private_key, signature_string)

      @client.add_header({'X-MW-SIGNATURE': hmac})
    end
  end
end