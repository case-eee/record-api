require 'grape'
require 'json'
require_relative 'record'

module RecordCollection
  class API < Grape::API
    version 'v1', using: :header, vendor: :record
    format :json
    prefix :api

    helpers do
      def format_data(data)
        { "data" => data }
      end
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
        Record.create({
                         firstname: params[:first_name],
                         lastname: params[:last_name],
                         gender: params[:gender],
                         favoritecolor: params[:favorite_color],
                         dateofbirth: params[:date_of_birth]
                     }).to_json
      end

      desc 'returns a list of records sorted by gender'
      get :gender do
        data = Record.by_gender.map {|record| record.to_json }
        format_data(data)
      end

      desc 'returns a list of records sorted by birthdate'
      get :birthdate do
        data = Record.by_birthdate.map {|record| record.to_json }
        format_data(data)
      end

      desc 'returns a list of records sorted by name'
      get :name do
        data = Record.by_name.map {|record| record.to_json }
        format_data(data)
      end
    end
  end
end

