require 'spec_helper'

describe Rack::Slashless do
  def app
    @app ||= Rack::Builder.new do
      use Rack::Slashless
      run lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['Hello World'] ] }
    end
  end

  context 'GET requests' do

    context 'without a path' do
      it 'should not redirect' do
        get '/', {}, 'SERVER_NAME' => 'www.example.org'
        last_response.status.should == 200
      end
    end

    context 'with a path that includes a trailing slash' do
      it 'should redirect to a url without a trailing slash' do
        get '/blog/', {}, 'SERVER_NAME' => 'www.example.org'
        last_response.status.should == 301
        last_response['Location'].should eql('http://www.example.org/blog')
      end
    end

    context 'with a query string' do
      it 'should retain the query string when redirecting' do
        get '/blog/?article=1', {}, 'SERVER_NAME' => 'example.org'
        last_response.status.should == 301
        last_response['Location'].should eql('http://example.org/blog?article=1')
      end
    end

  end

  context 'POST requests' do
    it 'should not redirect' do
      post '/blog/', {}, 'SERVER_NAME' => 'www.example.org'
      last_response.status.should == 200
    end
  end

end