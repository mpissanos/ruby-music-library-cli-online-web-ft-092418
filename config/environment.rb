
#This Is Yuour Environment File
#Require gems here.
require "bundler"
require 'rspec'


#This is used for name spacing.
module Concerns::Findable
 end


#This is used for requiring files within our project.
# require_relative "Other Files"
require_all 'lib'

