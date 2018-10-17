# frozen_string_literal: true

module Housecanary
  class Error < StandardError #:nodoc:
    attr_reader :code

    NoContent = Class.new(self)
    BadRequest = Class.new(self)
    Unauthorized = Class.new(self)
    Forbidden = Class.new(self)
    NotFound = Class.new(self)
    InternalServerError = Class.new(self)
    TooManyRequests = Class.new(self)

    ERRORS_MAP = {
      204 => Housecanary::Error::NoContent,
      400 => Housecanary::Error::BadRequest,
      401 => Housecanary::Error::Unauthorized,
      403 => Housecanary::Error::Forbidden,
      404 => Housecanary::Error::NotFound,
      429 => Housecanary::Error::TooManyRequests,
      500 => Housecanary::Error::InternalServerError
    }.freeze

    class << self
      def from_response(body)
        message, status = parse_error(body)
        new(message, status)
      end

      def parse_error(body)
        message = body.fetch(:message, nil) || body.fetch(:api_code_description, nil)
        status = body.fetch(:status, nil) || body.fetch(:api_code, nil)
        [message, status]
      end
    end

    private

    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end
  end
end
