#Initialize mbe file
require 'rubygems'
require 'bundler/setup'
require 'colorize'
require 'highline/import'
require 'yaml'
require 'wicked_pdf'
# require 'wkhtmltopdf-binary'

namespace :mbe do
  task :create_user do
    data = YAML::load_file('data/client.yml') #Load
    if data["name"].nil?
      name = ask("Your Name?")
      address = ask("Your Address?")
      mailbox = ask("Your mail box address?")

      data['name'] = name
      data['address'] = address
      data['mailbox'] = mailbox

      File.open('data/client.yml', 'w') {|f| f.write data.to_yaml }
    end
  end

  task generate: [:create_user] do
    p "HOLA"
  end

  task :perform do
    pdf = WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>')
    File.open('result/file.pdf', 'wb') do |file|
        file << pdf
    end
  end
end

