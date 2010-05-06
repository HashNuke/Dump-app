#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'active_record'
require 'json'

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

get '/fetchmsg' do
  content_type :json
  @msgs = Inbox.all()
  count_msg = 0
  total_json = []
  @msgs.each{ |msg|
    total_json.push({:id=>msg['ID'], :msg=>msg['TextDecoded'], :sender=>msg['SenderNumber']})
  }
  
  json_data = {:count=>total_json.length, :data=>total_json}
  json_data.to_json
end
