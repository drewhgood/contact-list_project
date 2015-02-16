require 'csv'

class ContactDatabase
  class << self
    def write_to_file(contact)
      file = File.open('contacts.csv','a')
      id = File.open('contacts.csv').readlines.size
      file.print "#{id},#{contact.name},#{contact.email}"
      contact.phones.each do |type, number|
        file.print ", #{type}: #{number}"
      end
      file.puts ''
      file.close  
    end

    def read_from_file
      customers = CSV.read('contacts.csv')
    end
  end


end

