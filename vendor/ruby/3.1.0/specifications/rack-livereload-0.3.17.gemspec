# -*- encoding: utf-8 -*-
# stub: rack-livereload 0.3.17 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-livereload".freeze
  s.version = "0.3.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Bintz".freeze]
  s.date = "2018-04-06"
  s.description = "Insert LiveReload into your app easily as Rack middleware".freeze
  s.email = ["john@coswellproductions.com".freeze]
  s.homepage = "https://github.com/onesupercoder/rack-livereload".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Insert LiveReload into your app easily as Rack middleware".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<cucumber>.freeze, ["< 3"])
    s.add_development_dependency(%q<httparty>.freeze, [">= 0"])
    s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_development_dependency(%q<shotgun>.freeze, [">= 0"])
    s.add_development_dependency(%q<thin>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-cucumber>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-livereload>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_development_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.2.0"])
    s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<cucumber>.freeze, ["< 3"])
    s.add_dependency(%q<httparty>.freeze, [">= 0"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_dependency(%q<shotgun>.freeze, [">= 0"])
    s.add_dependency(%q<thin>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<guard>.freeze, [">= 0"])
    s.add_dependency(%q<guard-rspec>.freeze, [">= 0"])
    s.add_dependency(%q<guard-cucumber>.freeze, [">= 0"])
    s.add_dependency(%q<guard-livereload>.freeze, [">= 0"])
    s.add_dependency(%q<guard-bundler>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.2.0"])
    s.add_dependency(%q<rack>.freeze, [">= 0"])
  end
end
