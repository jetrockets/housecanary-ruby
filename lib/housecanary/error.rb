# frozen_string_literal: true

module Housecanary
  class Error < StandardError #:nodoc:
    attr_reader :code

    BadRequest = Class.new(self)
    Unauthorized = Class.new(self)
    Forbidden = Class.new(self)
    NotFound = Class.new(self)
    InternalServerError = Class.new(self)
    TooManyRequests = Class.new(self)

    ERRORS_MAP = {
      400 => Housecanary::Error::BadRequest,
      401 => Housecanary::Error::Unauthorized,
      403 => Housecanary::Error::Forbidden,
      404 => Housecanary::Error::NotFound,
      429 => Housecanary::Error::TooManyRequests,
      500 => Housecanary::Error::InternalServerError
    }.freeze

    private

    def self.from_response(body)
      message, status = parse_error(body)
      new(message, status)
    end

    def self.parse_error(body)
      message = body.fetch(:message, nil)
      status = body.fetch(:status, nil)
      return message, status
    end

    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end
  end
end