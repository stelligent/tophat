require 'faraday'
require 'timeout'

module Serverspec
  module Type
    class Http_Get < Base
      def initialize(url, timeout_sec=10)
        @url = url
        begin
          Timeout::timeout(timeout_sec) do
            getpage
          end
        rescue Timeout::Error
          @timed_out_status = true
        end
      end
      def getpage
        conn = Faraday.new
        response = conn.get(@url)
        @response_code_int = response.status
        @content_str = response.body
        @headers_hash = response.headers.dup
      end
      def timed_out?
        @timed_out_status
      end
      def headers
        @headers_hash
      end
      def status
        @timed_out_status ? 0 : @response_code_int
      end
      def body
        @content_str
      end

      private :getpage
    end
    def http_get(url, timeout_sec=10)
      Http_Get.new(url, timeout_sec)
    end
  end
end

include Serverspec::Type
