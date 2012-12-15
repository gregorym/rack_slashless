Rack::Slashless
==============
Rack::Slashless is Rack application that redirects every GET requests ending by a `/` to the same url without the `/`.

Rack::Slashless is an easy SEO win, the gem will avoid duplicate contents across your site. For example, you can access the page `example.com/blog/` or `example.com/blog`, both have exactly the same content but with a different url, this causes a duplicate content for Google.

If you want more details regarding Duplicate Content, here is the [Guide](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=66359) from Google.

## Installation
Install the gem locally using:
``` ruby
gem install rack_slashless
```

... or add it to your project's Gemfile:
``` ruby
gem 'rack_slashless'
```

## Rails
**config/application.rb**
``` ruby
config.middleware.insert_before(0, "Rack::Slashless")
```

## Sinatra
**app.rb** (your application file)
``` ruby
require 'sinatra'
require 'rack_slashless'

use Rack::Slashless
```

## Author
Gregory Marcilhacy  
License: MIT