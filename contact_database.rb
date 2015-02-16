## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase



  class << self

    def write_to_file(contact)
      
      file = File.open('contacts.csv','a')
      id = File.open('contacts.csv').readlines.size #get contacts id via line number
      file.print "#{id},#{contact.name},#{contact.email}"
      contact.phones.each do |type, number|
        file.print ", #{type}: #{number}"
      end
      file.puts ''
      file.close  
    end

    def read_from_file
      # CSV.foreach('contacts.csv') do |row|
      #   puts row.inspect
      customers = CSV.read('contacts.csv')
      #end
    end

  end


end

