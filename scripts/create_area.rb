#!/usr/bin/env ruby
require 'pathname'
require 'rubygems'
require 'active_support/inflector'

BASE_DIR = Pathname.new( File.dirname(__FILE__) + "/.." ).cleanpath
SRC_PATH = File.join( BASE_DIR, "#{ARGV[0]}/#{ARGV[1]}" )
PRJ_NAME = ARGV[1]
TMPL_DIR = File.join( BASE_DIR, "scripts/templates/area/" )

#use shell to get area name from user
puts "Please inform the area name: "

#TODO: CHECK WHY THE FUCKING GETS ISNT WORKING HERE
#I THINK THAT IS A PROBLEM WITH FILE, ITS TRYING TO JOIN THE PATH BEFORE AREA_NAME GETS RETURNS
AREA_NAME = "Tests"

#read / supplant Controller template
CONTROLLER_NAME = AREA_NAME
CONTROLLER_PATH = File.join( SRC_PATH, "/controllers/" + CONTROLLER_NAME + "Controller.as" )

out = IO.read( File.join( TMPL_DIR, "/Controller.as" ) )
out = out.gsub( "PROJECT_NAME", PRJ_NAME );
out = out.gsub( "CONTROLLER_NAME", CONTROLLER_NAME )

#save file
File.open( CONTROLLER_PATH, 'w' ) { |f| f.write out }

#read / supplant Model template
MODEL_NAME = Inflector.singularize( AREA_NAME )
MODEL_PATH = File.join( SRC_PATH, "/models/" + CONTROLLER_NAME + "Model.as" )

out = IO.read( File.join( TMPL_DIR, "Model.as" ) )
out = out.gsub( "PROJECT_NAME", PRJ_NAME );
out = out.gsub( "MODEL_NAME", MODEL_NAME )

#save file
File.open( File.join( SRC_PATH, "/models/" + MODEL_NAME + "Model.as" ), 'w' ) { |f| f.write out }