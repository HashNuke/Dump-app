#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
#require 'active_record'
require 'dm-core'
require 'dm-validations'
require 'logger'


#ActiveRecord::Base.establish_connection(
#                                        :adapter=>"mysql",
#                                        :host=>"localhost",
#                                        :database=>"dumpapp",
#                                        :username=>"root",
#                                        :password=>"runningchamp")


### Environment configuration ###

configure :development do
  DataMapper.setup(:default, {
                     :adapter  => 'mysql',
                     :host     => 'localhost',
                     :username => 'root' ,
                     :password => 'runningchamp',
                     :database => 'dumpapp'})

  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do
  DataMapper.setup(:default, {
                     :adapter  => 'mysql',
                     :host     => 'localhost',
                     :username => 'root' ,
                     :password => 'runningchamp',
                     :database => 'dumpapp'})
end

### MODELS ###

class Inbox
  include DataMapper::Resource

  storage_names[:default] = "inbox"
  
  property :id, Integer,:serial=>true
  property :sendernumber, String
  property :textdecoded, String

  validates_present :textdecoded
end

get '/' do
    @inbox = Inbox.all :order=>[:id]
    haml :index
end

                                        
