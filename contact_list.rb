require_relative 'contact'
require_relative 'contact_database'
require 'pry'
require 'colorize'

arg1, arg2 = ARGV

def validate_email(email)
  email.match(/^\S+@\S+\.\S+$/) != nil
end

def validate_phone(phone)
  phone.to_s.match(/^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/) != nil
end 

def prompt(action)
  if action == 'name'
    puts "Enter Full Name:"
  elsif action == 'email'
    puts "Enter Email:"
  elsif action == 'phone_new'
    puts "Add phone number"
  elsif action == 'phone_type'
    puts "What type of phone are you adding?"
  elsif action == 'phone_number'
    puts "Add phone number"
  elsif action == 'phone_again?'
    puts "Add additional number? (Y / N) "
  elsif action == 'invalid_phone'
    puts "Not a valid phone number. Try again.".colorize(:red)
  elsif action == 'invalid_email'
    puts "Not a valid email address.".colorize(:red)
  end
end

case arg1

when "help"
  puts "Here is a list of available commands:
    new  - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"

when "new"
  prompt('email')
  email = STDIN.gets.chomp 

  if validate_email(email)
    if Contact.check_for_duplicates(email)
      puts 'Contact already exists!'.colorize(:red)

    else
      prompt('name')
      name = STDIN.gets.chomp

      prompt('phone_new')
      additional_phone_numbers = true
      phones ={}

      while additional_phone_numbers
        prompt('phone_type')
        type = STDIN.gets.chomp
        prompt('phone_number')
        number = STDIN.gets.chomp
        if validate_phone(number.to_s)
          phones[type] = number
          prompt('phone_again?')
          response = STDIN.gets.chomp.downcase
          response == 'y' ? additional_phone_numbers = true : additional_phone_numbers = false
        else
          prompt('invalid_phone')
        end
      end

      contact = Contact.create(name,email, phones)
    end

  else
   prompt('invalid_email')
  end

when "list"
  Contact.list

when "find"
  Contact.find(arg2)

when "show"
  Contact.show(arg2)

else
  puts "Try gain, or enter 'help' for more options"
end