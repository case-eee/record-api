require_relative 'spec_helper'

describe RecordCollection do
  let(:record_one) { Record.new(firstname: "Penelope", lastname: "Garcia", gender: "F", favoritecolor: "Orange", dateofbirth: "1988-11-08") }
  let(:record_two) { Record.new(firstname: "Pablo", lastname: "Marquez", gender: "M", favoritecolor: "Purple", dateofbirth: "1960-12-08") }
  let(:record_three) { Record.new(firstname: "Alfred", lastname: "Adams", gender: "M", favoritecolor: "Orange", dateofbirth: "1999-01-08") }
  let(:record_collection) { RecordCollection.new(records: [record_one, record_two, record_three]) }

  describe ".all" do
    it "returns a collection of record objects" do
      expect(record_collection.all).not_to be_empty
      expect(record_collection.all.first).to be_instance_of Record
    end
  end

  describe ".by_gender" do
    it "returns records sorted by gender, then last name" do
      expect(record_collection.by_gender).to match([record_one, record_three, record_two])
    end
  end

  describe ".by_name" do
    it "returns records sorted by last name" do
      expect(record_collection.by_name).to match([record_two, record_one, record_three])
    end
  end

  describe ".by_birthdate" do
    it "returns records sorted by birthdate" do
      expect(record_collection.by_birthdate).to match([record_two, record_one, record_three])
    end
  end
end