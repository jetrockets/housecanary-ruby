# frozen_string_literal: true

require 'dry-initializer'
require 'http'

module Housecanary
  class Connection # :nodoc:
    extend Dry::Initializer
    BASE_URL = 'https://api.housecanary.com/v2/'

    option :api_key
    option :api_secret

    def post(path, params = {})
      HTTP.basic_auth(user: api_key, pass: api_secret).post(url(path), params)
    end

    def get(path, params = {})
      ctx = OpenSSL::SSL::SSLContext.new
      ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE

      HTTP.basic_auth(user: api_key, pass: api_secret).get(url(path), {ssl_context: ctx}.merge(params))
    end

    private

    def url(path)
      URI.join(BASE_URL, path)
    end
  end
end
