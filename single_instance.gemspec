# -*- encoding: utf-8 -*-
require File.expand_path("../lib/single_instance/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "single_instance"
  s.version     = SingleInstance::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Vrensk", "Magnus Enarsson"]
  s.email       = ["rubygems+single_instance@vrensk.com"]
  s.homepage    = "http://github.com/dvrensk/single_instance"
  s.summary     = %Q{Ruby Gem that makes sure that only a single instance of a code block or process is running.}
  s.description = "SingleInstance uses an exclusive file lock to allow or block execution of code."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "single_instance"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "thoughtbot-shoulda", ">= 0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
