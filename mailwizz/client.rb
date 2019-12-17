module Mailwizz

  ##
  # Client is the http client interface used to make the remote requests and receive the responses.
  ##
  class Client < Base

    # Marker for GET requests.
    METHOD_GET = 'GET'

    # Marker for POST requests
    METHOD_POST = 'POST'

    # Marker for PUT requests
    METHOD_PUT = 'PUT'

    # Marker for DELETE requests
    METHOD_DELETE = 'DELETE'

    # Marker for the client version
    CLIENT_VERSION = '1.0'

    # the method used in the request.
    attr_accessor :method

    # the url where the remote calls will be made.
    attr_accessor :url

    # the default timeout for request.
    attr_accessor :timeout

    # the headers sent in the request.
    attr_accessor :headers

    # the GET params sent in the request.
    attr_accessor :params_get

    # the POST params sent in the request.
    attr_accessor :params_post

    # the PUT params sent in the request.
    attr_accessor :params_put

    # the DELETE params sent in the request.
    attr_accessor :params_delete

    def initialize(options)
      @params_get = @params_delete = @params_post = @params_put = {}
      __populate(options)
    end

    def request
      request = Request.new(self)
      request.send
    end

    def get_method?
      @method.upcase === METHOD_GET
    end

    def post_method?
      @method.upcase === METHOD_POST
    end

    def put_method?
      @method.upcase === METHOD_PUT
    end

    def delete_method?
      @method.upcase === METHOD_DELETE
    end

    ##
    # Add header info to the header attribute
    #
    # @param [Hash] header
    ##
    def add_header(header)
      @headers.merge!(header)
    end

    protected

    ##
    # Populate the client attributes
    # @param [Hash] options
    ##
    def __populate(options)
      if options.has_key?(:method)
        @method = options[:method]
      else
        @method = self.METHOD_GET
      end

      if options.has_key?(:url)
        @url = options[:url]
      else
        raise 'Please set the url where your request will be made.'
      end

      if options.has_key?(:params_get)
        @params_get = options[:params_get]
      end

      if options.has_key?(:params_post)
        @params_post = options[:params_post]
      end

      if options.has_key?(:params_put)
        @params_put = options[:params_put]
      end

      if options.has_key?(:params_delete)
        @params_delete = options[:params_delete]
      end

      if options.has_key?(:headers)
        @headers = add_header(options[:headers])
      else
        @headers = {}
      end
    end
  end
end