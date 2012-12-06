module Rack
  class Slashless

    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      if request.get? && request.path_info.match(/\w+\/$/)
        destination = [
                        "#{request.scheme}://",
                        request.env['SERVER_NAME'],
                        request.path_info[0..-2],
                        (request.query_string.empty? ? '' : "?#{request.query_string}")
                      ].join

        [301, {'Location' => destination}, ['Redirecting to the same url but with the ending /']]
      else
        @app.call(env)
      end
    end

  end
end