# frozen_string_literal: true

require 'dry-container'
require 'dry-auto_inject'
require 'ostruct'

require 'housecanary/version'
require 'housecanary/connection'
require 'housecanary/response_parser'

module Housecanary #:nodoc:
  @container = ::Dry::Container.new
  AutoInject = ::Dry::AutoInject(@container)

  def self.configure
    yield(configuration)
    register!
  end

  def self.container
    @container
  end

  def self.properties
    Housecanary::API::Repository.new
  end

  class << self
    private

    def configuration
      @configuration ||= OpenStruct.new
    end

    def register!
      connection = ::Housecanary::Connection.new(configuration.to_h)
      parser_class = ::Housecanary::ResponseParser
      container.register :connection, -> { connection }
      container.register :response_parser, -> { parser_class }
    end
  end
end

require 'housecanary/api/repository'
