require_relative 'parser'

class Record
  attr_reader :first_name, :last_name, :gender, :favorite_color, :date_of_birth

  def initialize(args = {})
    @first_name = args[:firstname]
    @last_name = args[:lastname]
    @gender = args[:gender]
    @favorite_color = args[:favoritecolor]
    @date_of_birth = args[:dateofbirth]
  end

  def self.all
    Parser.retrieve_records("data.csv")
  end

  def self.by_gender
    all.sort_by { |record| [record.gender, record.last_name] }
  end

  def self.by_name
    all.sort_by { |record| record.last_name }
  end

  def self.by_birthdate
    all.sort_by { |record| record.date_of_birth }
  end

  def self.create(args)
    new_record = self.new(args)
    new_record.save
    new_record
  end

  def save
    Parser.save_record("data.csv", attributes)
  end

  def attributes
    [first_name, last_name, gender, favorite_color, date_of_birth]
  end

  def to_json
    { firstName: first_name,
      lastName: last_name,
      gender: gender,
      favoriteColor: favorite_color,
      dateOfBirth: date_of_birth
    }
  end
end


