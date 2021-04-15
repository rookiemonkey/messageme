module Exceptions
  module ApplicationErrors
    class AccountError < StandardError
      attr_reader :message, :path

      def initialize(data)
        @message = data[:message]
        @path = data[:path]
        super
      end
    end
  end
end
