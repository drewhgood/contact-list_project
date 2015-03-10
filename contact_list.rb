require_relative 'contact'
require_relative 'contact_database'
require 'pry'
require 'colorize'

arg1, arg2 = ARGV

def invalid_email?(email)
  email.match(/^\S+@\S+\.\S+$/) == nil
end

def validate_phone(phone)
  phone.to_s.match(/^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/) != nil
end 

def gather_input
  STDIN.gets.chomp
end 

def success(name, email, phones)
  puts "Success! You added:".colorize(:green)
  puts "#{name}: #{email}".colorize(:green)
  
  phones.each do |type, number|
    print"#{type}: #{number} | ".colorize(:green)
  end
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
    puts "Address already exists, or is not valid.".colorize(:red)
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
    email = gather_input

    if invalid_email?(email) || Contact.check_for_duplicates(email)
      prompt('invalid_email')

    else
      prompt('name')
      name = gather_input
      prompt('phone_new')
      additional_phone_numbers = true
      phones ={}

      while additional_phone_numbers
        prompt('phone_type')
        type = gather_input
        prompt('phone_number')
        number = gather_input

        if validate_phone(number.to_s)
          phones[type] = number
          prompt('phone_again?')
          additional_phone_numbers = false if gather_input.downcase != 'y'
        else
          prompt('invalid_phone')
        end
      end
     Contact.create(name, email, phones)
     success(name, email, phones)
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