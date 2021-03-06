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
        get '/', {}, 'HTTP_HOST' => 'example.org'
        last_response.status.should == 200
      end
    end

    context 'with a path that does not include a trailing slash' do
      it 'should not redirect' do
        get '/blog', {}, 'HTTP_HOST' => 'example.org'
        last_response.status.should == 200
      end
    end

    context 'with a path that includes a trailing slash' do
      it 'should redirect to a url without a trailing slash' do
        get '/blog/', {}, 'HTTP_HOST' => 'example.org'
        last_response.status.should == 301
        last_response['Location'].should eql('http://example.org/blog')
      end

      it 'should redirect and provide a Content-Type' do
        get '/blog/', {}, 'HTTP_HOST' => 'example.org'
        last_response.status.should == 301
        last_response['Content-Type'].should eql('text/html')
      end
    end

    context 'with a query string' do
      it 'should retain the query string when redirecting' do
        get '/blog/?article=1', {}, 'HTTP_HOST' => 'example.org'
        last_response.status.should == 301
        last_response['Location'].should eql('http://example.org/blog?article=1')
      end
    end

    context 'with a port' do
      it 'should retain the port when redirecting' do
        get '/blog/', {}, 'HTTP_HOST' => 'example.org', 'SERVER_PORT' => '3000'
        last_response.status.should == 301
        last_response['Location'].should eql('http://example.org:3000/blog')
      end
    end

    context 'with a subdomain' do
      it 'should retain the subdomain when redirecting' do
        get '/blog/', {}, 'HTTP_HOST' => 'www.example.org'
        last_response.status.should == 301
        last_response['Location'].should eql('http://www.example.org/blog')
      end
    end

  end

  context 'POST requests' do
    it 'should not redirect' do
      post '/blog/', {}, 'HTTP_HOST' => 'example.org'
      last_response.status.should == 200
    end
  end

end