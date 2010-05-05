#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'active_record'

### ActiveRecord db credentials ###

ActiveRecord::Base.establish_connection(
                                        :adapter=>"mysql",
                                        :host=>"localhost",
                                        :database=>"dumpapp",
                                        :username=>"root",
                                        :password=>"runningchamp")

### MODELS ###

class Inbox < ActiveRecord::Base
  set_table_name "inbox"
end

### Actions  ###

get '/' do
  @inbox = Inbox.all()
  #Inbox.delete(1)
  haml :index
end

                                        
