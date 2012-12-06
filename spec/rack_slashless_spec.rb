require 'spec_helper'

describe Rack::Slashless do
  def app
    @app ||= Rack::Builder.new do
      use Rack::Slashless
      run lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['Hello World'] ] }
    end
  end

  describe "/" do
    it "should redirect to server name" do
      get '/', {}, {'SERVER_NAME' => 'www.example.org'}
      
      last_response.status.should == 301
      last_response['Location'].should eql('http://www.example.org')
    end
  end

  describe "/blog/" do
    it "should redirect to /blog" do
      get '/blog/', {}, {'SERVER_NAME' => 'www.example.org'}

      last_response.status.should == 301
      last_response['Location'].should eql('http://www.example.org/blog')
    end
  end

  describe "/blog?article=1" do
    it "should not redirect" do
      get '/blog?article=1', {}, {'SERVER_NAME' => 'www.example.org'}

      last_response.status.should == 200
    end
  end

  describe "POST /blog" do
    it "should not redirect" do
      post '/blog/', {}, {'SERVER_NAME' => 'www.example.org'}

      last_response.status.should == 200
    end
  end

end