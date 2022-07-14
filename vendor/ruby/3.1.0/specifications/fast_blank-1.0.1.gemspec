# -*- encoding: utf-8 -*-
# stub: fast_blank 1.0.1 ruby lib
# stub: ext/fast_blank/extconf.rb

Gem::Specification.new do |s|
  s.name = "fast_blank".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sam Saffron".freeze]
  s.date = "2021-08-17"
  s.description = "Provides a C-optimized method for determining if a string is blank".freeze
  s.email = "sam.saffron@gmail.com".freeze
  s.extensions = ["ext/fast_blank/extconf.rb".freeze]
  s.files = ["ext/fast_blank/extconf.rb".freeze]
  s.homepage = "https://github.com/SamSaffron/fast_blank".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Fast String blank? implementation".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<benchmark-ips>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<benchmark-ips>.freeze, [">= 0"])
  end
end
