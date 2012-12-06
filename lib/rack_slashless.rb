module Rack
  class Slashless

    def initialize(app)
      @app = app
    end

    def call(env)
      if env['REQUEST_METHOD'] == "GET" && env['QUERY_STRING'].empty? && env['PATH_INFO'].end_with?("/")
        parts = env['SERVER_NAME'].split('.')
        suffix, chunk, prefix = parts.pop, parts.pop, parts.pop

        destination = "#{env['rack.url_scheme']}://"
        destination << "#{prefix}." if prefix
        destination << "#{chunk}.#{suffix}"
        destination << "#{env['PATH_INFO']}"[0..-2]
        
        [301, {'Location' => destination}, ['Redirecting to the same url but with the ending /']]
      else
        @app.call(env)
      end
    end

  end
end