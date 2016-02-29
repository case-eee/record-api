require 'csv'
require_relative 'record'

module Parser
  def self.retrieve_records(file)
    records = []
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      records << Record.new(row)
    end
    records
  end

  def self.save_records(file, data)
    headers = ["LastName","FirstName","Gender","FavoriteColor","DateOfBirth"]
    CSV.open(file, "w") do |csv|
      csv << headers
      data.each do |record|
        csv << record.attributes
      end
    end
  end
end

