#Initialize mbe file
require 'rubygems'
require 'bundler/setup'
require 'colorize'
require 'highline/import'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'dbfile.sqlite3')
class Client < ActiveRecord::Base; end
namespace :mbe do
  task :generate do
    Client.new
    name = ask("Your Name?")
    p name
  end
end

