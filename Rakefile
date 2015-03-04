#Initialize mbe file
require 'rubygems'
require 'bundler/setup'
require 'colorize'
require 'highline/import'
require 'yaml'
require 'wicked_pdf'
require 'erb'

class Invoice
  attr_accessor :client, :reference, :shipper, :items

  def self.for(params)
    invoice = new(params['invoice'])
    invoice.client = Client.new(params['client'])
    invoice.items = params['invoice']['items'].map {|item| Item.new(item) }
    invoice
  end

  def get_binding
    binding
  end

  def total
    @items.map(&:total).reduce(:+)
  end

  def qty_total
    @items.map(&:qty).reduce(:+)
  end

  def initialize(params)
    @reference = params['reference']
    @shipper   = params['shipper']
  end

  class Client
    attr_accessor :name, :address, :mailbox

    def initialize(params)
      @name = params['name']
      @address = params['address']
      @mailbox = params['mailbox']
    end
  end

  class Item
    attr_accessor :package, :name, :value, :qty

    def initialize(params)
      @name = params['name']
      @package = params['package']
      @value = params['value']
      @qty = params['qty']
    end

    def total
      @qty * @value
    end
  end
end

namespace :mbe do
  task :create_database  do
    exec "cp ./data/client.yml.example ./data/client.yml"
  end

  task :remove_user do
    puts "Removing client information....".blue
    data = YAML::load_file('data/client.yml') #Load
    data.delete 'client'
    File.open('data/client.yml', 'w') {|f| f.write data.to_yaml }
  end

  task :create_user do
    puts "Loading client information....".blue
    data = YAML::load_file('data/client.yml') #Load
    if data["client"].nil?
      name = ask("Your Name?")
      address = ask("Your Address?")
      mailbox = ask("Your mail box address?")
      data['client'] = {}
      data['client']['name'] = name.to_s
      data['client']['address'] = address.to_s
      data['client']['mailbox'] = mailbox.to_s

      File.open('data/client.yml', 'w') {|f| f.write data.to_yaml }
    end
  end

  task :create_invoice do
    puts "Loading invoice information....".blue
    data = YAML::load_file('data/client.yml') #Load

    invoice = { 'items' => [] }
    invoice['reference'] = ask("Reference number:").to_s
    shipper = ask("Shipper name:"){ |q| q.default = "Amazon Logistic" }
    invoice['shipper']  = shipper.to_s

    puts "Creating items....".blue
    done = true
    while(done==true)
      item = {}
      item['package'] = ask("Package qty:", Integer){ |q| q.default = 1 }
      item['name'] = ask("Item name:").to_s { |q| q.validate != "" }
      item['qty'] = ask("Item quantity:", Integer){ |q| q.default = 1 }
      item['value'] = ask("Item value:", Float){ |q| q.default = 2.00 }
      invoice['items'] << item

      more_item = ask("more item?(y/n)"){ |q| q.validate = /[y,n]/ }
      done = more_item == "y" ? true : false
    end

    data['invoice'] = invoice
    File.open('data/client.yml', 'w') {|f| f.write data.to_yaml }
  end

  task :generate_pdf do
    puts "Generating PDF....".blue
    data = YAML::load_file('data/client.yml') #Load
    @invoice = Invoice.for(data)

    path  =   File.expand_path(File.join(File.dirname(__FILE__), "data/template.htm.erb"))
    html  = ERB.new(File.read(path)).result(@invoice.get_binding)

    pdf = WickedPdf.new.pdf_from_string(html)
    File.open('result/file.pdf', 'wb') do |file|
      file << pdf
    end

    puts "Enjoy your file".green
    exec 'open result/file.pdf'
  end

  task generate: [:create_user, :create_invoice, :generate_pdf] do

  end
end

