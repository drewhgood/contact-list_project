class Contact
  @@contacts = []
  attr_accessor :name, :email, :phones
 
  def initialize(name, email, phones)
    @name = name
    @email = email
    @phones = phones
  end

  class << self
    def create(name, email, phones)
      contact = Contact.new(name, email, phones)
      @@contacts << contact
      db = ContactDatabase.new
      ContactDatabase.write_to_file(contact)
    end

    def list
      all_contacts = ContactDatabase.read_from_file
      all_contacts.each do |contacts|
        p " #{contacts[0]}: #{contacts[1]} (#{contacts[2]})"  
      end
    end
 
    def show(index)
      all_contacts = ContactDatabase.read_from_file
      all_contacts.each do |contacts|
        if contacts[0] == index
          p " #{contacts[0]}: #{contacts[1]} (#{contacts[2]})" 
        end 
      end
    end

    def find(search)
     all_contacts = ContactDatabase.read_from_file
      all_contacts.each do |contacts|
        if contacts[1] =~ /#{search}/i or contacts[2] =~ /#{search}/i
          p " #{contacts[0]}: #{contacts[1]} (#{contacts[2]})" 
        end 
      end
    end

    def check_for_duplicates(search)
      matches = 0 
      all_contacts = ContactDatabase.read_from_file
      all_contacts.each do |contacts|
        if contacts[2] == search.downcase
          matches += 1
        end 
      end
      matches > 0 ? true : false
    end 
  end
end

