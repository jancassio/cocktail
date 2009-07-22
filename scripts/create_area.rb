#!/usr/bin/env ruby
require 'pathname'
require 'rubygems'
require 'active_support/inflector'
require File.dirname($0) + '/shake'

BASE_DIR = Pathname.new( File.dirname(__FILE__) + "/.." ).cleanpath
SRC_PATH = File.join( BASE_DIR, "#{ARGV[0]}/#{ARGV[1]}" )
PRJ_NAME = ARGV[1]
TMPL_DIR = File.join( BASE_DIR, "scripts/templates/area/" )

#use shell to get area name from user
puts "Please inform the area name: "
AREA_NAME = STDIN.gets.chomp

#read / supplant Controller template
CONTROLLER_NAME = AREA_NAME
CONTROLLER_PATH = File.join( SRC_PATH, "/controllers/" + CONTROLLER_NAME + "Controller.as" )

Shake.supplant(
  File.join( TMPL_DIR, "/Controller.as" ),
  CONTROLLER_PATH,
  {
    "PROJECT_NAME" => PRJ_NAME,
    "CONTROLLER_NAME" => CONTROLLER_NAME 
  }
)

#read / supplant Model template
MODEL_NAME = Inflector.singularize( AREA_NAME )
MODEL_PATH = File.join( SRC_PATH, "/models/" + MODEL_NAME + "Model.as" )

Shake.supplant(
  File.join( TMPL_DIR, "Model.as" ), 
  MODEL_PATH, 
  {
    "PROJECT_NAME" => PRJ_NAME,
    "MODEL_NAME" => MODEL_NAME
  }
)