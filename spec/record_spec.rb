require_relative 'spec_helper'

describe Record do
  let(:record_one) { Record.new(firstname: "Penelope", lastname: "Garcia", gender: "F", favoritecolor: "Orange", dateofbirth: "1988-11-08") }
  let(:record_two) { Record.new(firstname: "Pablo", lastname: "Marquez", gender: "M", favoritecolor: "Purple", dateofbirth: "1960-12-08") }
  let(:record_three) { Record.new(firstname: "Alfred", lastname: "Adams", gender: "M", favoritecolor: "Orange", dateofbirth: "1999-01-08") }

  describe "#first_name" do
    it "returns the value of the record's first_name" do
      expect(record_one.first_name).to eq("Penelope")
    end
  end

  describe "#last_name" do
    it "returns the value of the record's last_name" do
      expect(record_one.last_name).to eq("Garcia")
    end
  end

  describe "#gender" do
    it "returns the value of the record's gender" do
      expect(record_one.gender).to eq("F")
    end
  end

  describe "#favorite_color" do
    it "returns the value of the record's favorite_color" do
      expect(record_one.favorite_color).to eq("Orange")
    end
  end

  describe "#date_of_birth" do
    it "returns the value of the record's date_of_birth" do
      expect(record_one.date_of_birth).to eq("1988-11-08")
    end
  end

  describe "#attributes" do
    it "returns an array of the record's attributes for saving purposes" do
      expect(record_one.attributes).to be_a Array
      expect(record_one.attributes).to eq(["Penelope", "Garcia", "F", "Orange", "1988-11-08"])
    end
  end

  describe ".all" do
    it "returns a collection of record objects" do
      expect(Record.all).not_to be_empty
      expect(Record.all.first).to be_instance_of Record
    end
  end

  describe ".by_gender" do
    it "returns records sorted by gender, then last name" do
      allow(Record).to receive(:all) { [record_one, record_two, record_three] }
      expect(Record.by_gender).to match([record_one, record_three, record_two])
    end
  end

  describe ".by_name" do
    it "returns records sorted by last name" do
      allow(Record).to receive(:all) { [record_one, record_two, record_three] }
      expect(Record.by_name).to match([record_three, record_one, record_two])
    end
  end

  describe ".by_birthdate" do
    it "returns records sorted by birthdate" do
      allow(Record).to receive(:all) { [record_one, record_two, record_three] }
      expect(Record.by_birthdate).to match([record_two, record_one, record_three])
    end
  end

  describe "#to_json" do
    it "returns the record object in a json format" do
      json_record = { firstName: record_one.first_name,
                    lastName: record_one.last_name,
                    gender: record_one.gender,
                    favoriteColor: record_one.favorite_color,
                    dateOfBirth: record_one.date_of_birth
                  }
      expect(record_one.to_json).to eq(json_record)
    end
  end
end