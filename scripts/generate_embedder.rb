#!/usr/bin/env ruby
require 'pathname'

BASE_DIR = Pathname.new( File.dirname(__FILE__) + "/.." ).cleanpath
SRC_PATH = "#{ARGV[0]}/#{ARGV[1]}"
PRJ_NAME = ARGV[1];
EMB_PATH = BASE_DIR, SRC_PATH + "/boot/Embedder.as"

#list all views/controller/models in the application
#convert filepath to classpaths

lines = Dir[ File.join( BASE_DIR, SRC_PATH + "/**/*.as" ) ]\
.grep( %r[.*/(views|controllers|models)] )\
.map{ |s| 
	s[ s.index( PRJ_NAME), s.length ].gsub( "/", "." ).gsub( ".as", ";" ) 
}

#read template
#replace stubs
out = IO.read( File.join( BASE_DIR, "scripts/templates/Embedder.as" ) )
out = out.sub( "PROJECT_NAME", PRJ_NAME )
out = out.sub( /^(\s*)YOUR_CODE_HERE/ ) {
  lines.map { |s|
    [$1, s].join("")
  }.join("\n")
}

#save file
File.open( File.join( EMB_PATH ), 'w' ) { |f| f.write out }