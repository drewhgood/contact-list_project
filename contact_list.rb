require_relative 'contact'
require_relative 'contact_database'
require 'pry'

arg1, arg2 = ARGV

case arg1
when "help"
  p "Here is a list of available commands:
    new  - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact\n"
when "new"
  p "Enter Email: "
  email = STDIN.gets.chomp 
  if Contact.check_for_duplicates(email)
    p 'Contact already exists'
  else
    p "Enter Full Name: "
    name = STDIN.gets.chomp
    p "Add phone number:"
    response = 'y'
    phones ={}
    while response == 'y'
      p "Type: "
      type = STDIN.gets.chomp
      p "Number: "
      number = STDIN.gets.chomp
      phones[type] = number
      p"Add additional number? (Y / N) "
      response = STDIN.gets.chomp.downcase
      end
    contact = Contact.create(name,email, phones)
  end
when "list"
  Contact.list
when "find"
  Contact.find(arg2)
when "show"
  Contact.show(arg2)
else
  puts "nothing happened"
end


class Application




end