require_relative 'spec_helper'

RSpec.configure do |config|
  config.rack_app = RecordAPI::API
end

describe RecordAPI::API do
  let(:record_one) { Record.new(firstname: "Penelope", lastname: "Garcia", gender: "F", favoritecolor: "Orange", dateofbirth: "1988-11-08") }
  let(:record_two) { Record.new(firstname: "Pablo", lastname: "Marquez", gender: "M", favoritecolor: "Purple", dateofbirth: "1960-12-08") }
  let(:record_three) { Record.new(firstname: "Alfred", lastname: "Adams", gender: "M", favoritecolor: "Orange", dateofbirth: "1999-01-08") }
  let(:record_collection) { RecordCollection.new(records: [record_one, record_two, record_three]) }

  context 'GET /api/records/gender' do
    it 'returns 200 response' do
      get "/api/records/gender"
      expect(response.status).to eq(200)
    end

    it 'returns data as json' do
      get "/api/records/gender"
      expect(response.header['Content-Type']).to include("application/json")
    end

    it 'returns all records sorted by gender' do
      get "/api/records/gender"
      json_response = JSON.parse(response.body)
      expect(json_response["data"][0]["firstName"]).to eq("Penelope")
    end
  end

  context 'GET /api/records/birthdate' do
    it 'returns 200 response' do
      get "/api/records/birthdate"
      expect(response.status).to eq(200)
    end

    it 'returns data as json' do
      get "/api/records/birthdate"
      expect(response.header['Content-Type']).to include("application/json")
    end

    it 'returns all records sorted by birthdate' do
      get "/api/records/birthdate"
      json_response = JSON.parse(response.body)
      expect(json_response["data"][0]["dateOfBirth"]).to eq("1965-09-15")
    end
  end

  context 'GET /api/records/name' do
    it 'returns 200 response' do
      get "/api/records/name"
      expect(response.status).to eq(200)
    end

    it 'returns data as json' do
      get "/api/records/name"
      expect(response.header['Content-Type']).to include("application/json")
    end

    it 'returns all records sorted by name' do
      get "/api/records/name"
      json_response = JSON.parse(response.body)
      expect(json_response["data"][0]["lastName"]).to eq("Garcia")
    end
  end

  context 'POST /api/records' do
    let(:data) { { "first_name" => "Penelope",
                              "last_name" => "Garcia",
                              "gender" => "F",
                              "favorite_color" => "Orange",
                              "date_of_birth" => "1999-12-09"
                  } }

    context "record saves" do
      it 'returns 201 response' do
        post "/api/records", data
        expect(response.status).to eq(201)
      end

      it 'returns data as json' do
        post "/api/records", data
        expect(response.header['Content-Type']).to include("application/json")
      end

      it 'returns the record' do
        post "/api/records", data
        json_response = JSON.parse(response.body)
        new_record = { "firstName" => "Penelope", "lastName" => "Garcia", "gender" => "F", "favoriteColor" => "Orange", "dateOfBirth" => "1999-12-09"}
        expect(json_response).to eq(new_record)
      end

      it 'adds the record to the csv file' do
        expect{ post "/api/records", data }.to change{ record_collection.all.length }.by(1)
      end
    end
  end

  context "record does not save" do
    it 'returns 400 response' do
      post "/api/records"
      expect(response.status).to eq(400)
    end

    it 'returns a missing params error' do
      post "/api/records"
      error_message = {"error"=>"first_name is missing, last_name is missing, gender is missing, favorite_color is missing, date_of_birth is missing"}
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error_message)
    end

    it 'does not add the record to the csv file' do
      expect{ post "/api/records" }.to change{ record_collection.all.length }.by(0)
    end
  end
end