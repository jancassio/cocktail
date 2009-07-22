#!/usr/bin/env ruby
require 'pathname'
require File.dirname($0) + '/shake'

BASE_DIR = Pathname.new( File.dirname(__FILE__) + "/.." ).cleanpath
SRC_PATH = BASE_DIR + "#{ARGV[0]}/#{ARGV[1]}"
PRJ_NAME = ARGV[1]

#find and list app views/controller/models
#then convert filepath to classpaths

lines = Dir[ File.join( SRC_PATH, "/**/*.as" ) ].grep( %r[.*/(views|controllers|models)] )\
.map{ |s| 
	s[ s.index( PRJ_NAME ), s.length ].gsub( "/", "." ).gsub( ".as", ";" ) 
}

#add \t to feat the template formmatting
lines = lines.map { |s| [ "\t\t\t", s].join("") }.join("\n")

#write Embedder Class
Shake::supplant( 
  File.join( BASE_DIR, "scripts/templates/Embedder.as" ), 
  File.join( SRC_PATH, "/boot/Embedder.as" ), 
  { 
    "PROJECT_NAME" => PRJ_NAME,
    /^(\s*)YOUR_CODE_HERE/ => lines
  }
)