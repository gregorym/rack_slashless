Gem::Specification.new do |gem|
  gem.authors       = ["Gregory Marcilhacy"]
  gem.email         = ["g.marcilhacy@gmail.com"]
  gem.description   = gem.summary = "Performs a 301 redirection on every url ending by a /"
  gem.homepage      = "https://github.com/gregorym/rack_slashless"
  
  gem.files         = `git ls-files | grep -v myapp`.split("\n")
  gem.test_files    = `git ls-files -- spec/*`.split("\n")
  gem.name          = "rack_slashless"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.5"
  gem.license       = "MIT"

  gem.add_development_dependency 'rspec', '>= 2'
  gem.add_development_dependency 'rack-test'
end