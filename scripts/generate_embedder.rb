#!/usr/bin/env ruby
require 'yaml'
require 'pathname'

BASE_DIR = Pathname.new(File.dirname(__FILE__) + "/..").cleanpath

lines = Dir[File.join(BASE_DIR, "#{ARGV[0]}/#{ARGV[1]}/**/*.as")]\
.grep(%r[.*/(views|controllers|models)])\
.map{ |s| s[ s.index( ARGV[1] ), s.length ].gsub( "/", "." ).gsub( ".as", "" ) }

out = IO.read(File.join(BASE_DIR, "scripts/templates/Embedder.as"))\
.sub(/^(\s*)YOUR_CODE_HERE/) { lines.map { |s| [$1, s].join("") }.join("\n") }

File.open(File.join(BASE_DIR, "#{ARGV[0]}/#{ARGV[1]}/boot/Embedder.as"), 'w') { |f| f.write out }