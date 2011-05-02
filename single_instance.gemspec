# -*- encoding: utf-8 -*-
require File.expand_path("../lib/single_instance/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "single_instance"
  s.version     = SingleInstance::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Vrensk", "Magnus Enarsson"]
  s.email       = ["dev+gemsupport@icehouse.se"]
  s.homepage    = "http://github.com/icehouse/single_instance"
  s.summary     = %Q{Ruby Gem that makes sure that only a single instance of a code block is running.}
  s.description = "TODO: Write a gem description"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "single_instance"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "thoughtbot-shoulda", ">= 0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
