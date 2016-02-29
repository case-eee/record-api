class RecordCollection
  attr_reader :records

  def initialize(args = {})
    @records = args[:records]
  end

  def all
    @records
  end

  def by_gender
    @records.sort_by { |record| [record.gender, record.last_name] }
  end

  def by_name
    @records.sort_by { |record| record.last_name }
  end

  def by_birthdate
    @records.sort_by { |record| record.date_of_birth }
  end

  def save(record)
    @records << record
  end

end