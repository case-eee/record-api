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
      expect(record_one.attributes).to eq(["Garcia", "Penelope", "F", "Orange", "1988-11-08"])
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

  describe ".create" do
    it "creates and returns a new Record object" do
      record_args = {firstname: "Penelope", lastname: "Garcia", gender: "F", favoritecolor: "Orange", dateofbirth: "1988-11-08"}
      new_record = Record.create(record_args)
      expect(new_record).to be_an_instance_of Record
      expect(new_record.first_name).to eq("Penelope")
    end
  end
end