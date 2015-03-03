#Initialize mbe file
require 'rubygems'
require 'bundler/setup'
require 'colorize'
require 'highline/import'
require 'yaml'

namespace :mbe do
  task :create_user do
    d = YAML::load_file('data/client.yml') #Load
    if d["name"].nil?
      name = ask("Your Name?")
      address = ask("Your Address?")
      mailbox = ask("Your mail box address?")
      d['name'] = name
      d['address'] = address
      d['mailbox'] = mailbox
      File.open('data/client.yml', 'w') {|f| f.write d.to_yaml } #Store

    end
  end

  task generate: [:create_user] do
    p "HOLA"
  end
end

