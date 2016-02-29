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

  def self.save_record(file, data)
    CSV.open(file, "a") do |csv|
      csv << data
    end
  end
end

