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

  def self.create(args)
    self.new(args)
  end

  def attributes
    [last_name, first_name, gender, favorite_color, date_of_birth]
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


