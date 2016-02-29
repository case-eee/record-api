require 'grape'
require 'json'
require_relative 'parser'
require_relative 'record_collection'

module RecordAPI
  class API < Grape::API
    version 'v1', using: :header, vendor: :record
    format :json
    prefix :api

    helpers do
      def format_data(data)
        { "data" => data.map {|record| record.to_json } }
      end

      def development_database
        "data.csv"
      end
    end

    before do
      records = Parser.retrieve_records(development_database)
      @record_collection = RecordCollection.new(records: records)
    end

    resource :records do
      desc 'adds a new record to our collection of records'

      params do
        requires :first_name, type: String, desc: 'First Name'
        requires :last_name, type: String, desc: 'Last Name'
        requires :gender, type: String, desc: 'M/F/O'
        requires :favorite_color, type: String, desc: 'Favorite Color'
        requires :date_of_birth, type: String, desc: 'Birth Date'
      end

      post do
        record = Record.create({
                                  firstname: params[:first_name],
                                  lastname: params[:last_name],
                                  gender: params[:gender],
                                  favoritecolor: params[:favorite_color],
                                  dateofbirth: params[:date_of_birth]
                              })
        @record_collection.save(record)
        Parser.save_records(development_database, @record_collection.all)
        record.to_json
      end

      desc 'returns a list of records sorted by gender'
      get :gender do
        format_data(@record_collection.by_gender)
      end

      desc 'returns a list of records sorted by birthdate'
      get :birthdate do
        format_data(@record_collection.by_birthdate)
      end

      desc 'returns a list of records sorted by name'
      get :name do
        format_data(@record_collection.by_name)
      end
    end
  end
end


