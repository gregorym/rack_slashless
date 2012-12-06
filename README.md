rack-slashless
==============

Rack::Slashless is Rack application that redirects every GET requests ending by a ````/```` to the same url without the ````/````.
Rack::Slashless is an easy SEO win, the gem will avoid duplicate contents across your site. For example, you can access the page ````example.com/blog/```` or ````example.com/blog````, both have exactly the same content but with a different url, this causes a duplicate content for Google.

If you want more details regarding Duplicate Content, here is the [Guide](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=66359) from Google.

Installation
============

````Ruby
gem install rack_slashless
````

Rails
=====

config/application.rb
````Ruby
config.middleware.insert_before(0, "Rack::Slashless")
````

Author
======

Gregory Marcilhacy<br/>
License: MIT