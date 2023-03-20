# -*- encoding: utf-8 -*-
# stub: middleman-cli 4.4.3 ruby lib

Gem::Specification.new do |s|
  s.name = "middleman-cli".freeze
  s.version = "4.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thomas Reynolds".freeze, "Ben Hollis".freeze]
  s.date = "2022-11-09"
  s.description = "A static site generator. Provides dozens of templating languages (Haml, Sass, Compass, Slim, CoffeeScript, and more). Makes minification, compression, cache busting, Yaml data (and more) an easy part of your development cycle.".freeze
  s.email = ["me@tdreyno.com".freeze, "ben@benhollis.net".freeze]
  s.executables = ["middleman".freeze]
  s.files = ["bin/middleman".freeze]
  s.homepage = "http://middlemanapp.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.4.1".freeze
  s.summary = "Hand-crafted frontend development".freeze

  s.installed_by_version = "3.4.1" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<thor>.freeze, [">= 0.17.0", "< 2.0"])
end
