Gem::Specification.new do |s|
  s.name        = 'oh_my_rockness'
  s.version     = '0.0.1'
  s.date        = '2016-12-28'
  s.summary     = "Scrape ohmyrockness.com"
  s.description = "Get show data from ohmyrockness.com"
  s.authors     = ["Mitchell Smith"]
  s.email       = 'gems@mitchellzsmith.com'
  s.files       = ["lib/oh_my_rockness.rb"]
  s.homepage    = 'http://github.com/smitchsmith/oh_my_rockness'
  s.license     = 'MIT'

  s.add_dependency 'mechanize'
  s.add_dependency 'capybara'
  s.add_dependency 'poltergeist'
end
