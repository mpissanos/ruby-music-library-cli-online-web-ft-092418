
#This Is Yuour Environment File
#Require gems here.
require "bundler"
require 'rspec'


#This is used for name spacing.
module Concerns::Findable
  
    def find_by_name(name)
      self.all.detect {|song| song.name == name}
    end
   
    def find_or_create_by_name(name)
      find_by_name(name) || create(name)
    end
  end
end

#This is used for requiring files within our project.
# require_relative "Other Files"
require_all 'lib'
