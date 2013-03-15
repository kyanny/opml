require 'rubygems'
require 'rake'
require 'rake/packagetask'
require 'rake/gempackagetask'
require File.join(File.dirname(__FILE__), 'lib', 'opml')

PKG_NAME      = 'opml'
PKG_VERSION   = Opml::VERSION::STRING
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"
dist_dirs = [ "lib", "test", "examples", "dev-utils" ]

spec = Gem::Specification.new do |s|
  s.name = PKG_NAME
  s.version = PKG_VERSION
  s.summary = "A simple wrapper for parsing OPML files."

  s.files = [ "MIT-LICENSE", "Rakefile", "README" ]
  %w( lib spec ).each do |dir|
    s.files = s.files + Dir.glob( "#{dir}/**/*" ).delete_if { |item| item.include?( "\.svn" ) }
  end

  s.require_path = 'lib'
  s.autorequire = 'opml'

  s.author = "Joshua Peek"
  s.email = "josh@joshpeek.com"
  s.homepage = "http://rubyforge.org/projects/opml/"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_zip = true
  p.need_tar = true
end
