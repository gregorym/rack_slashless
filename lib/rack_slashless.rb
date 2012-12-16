module Rack
  class Slashless

    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      if request.get? && request.path_info.match(/.+\/$/)
        destination = request.url.gsub(/\/(\?.*)?$/,'\1')
        [301, {'Location' => destination}, ["Redirecting to #{destination}"]]
      else
        @app.call(env)
      end
    end

  end
end