require 'csv'
require_relative 'record'

module Parser
  def self.retrieve_records
    records = []
    CSV.foreach("data.csv", headers: true, header_converters: :symbol) do |row|
      records << Record.new(row)
    end
    records
  end

  def self.save_record(data)
    CSV.open("data.csv", "a") do |csv|
      csv << data
    end
  end
end

