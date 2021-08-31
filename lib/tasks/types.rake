# frozen_string_literal: true

namespace :types_request do
  task save_types: :environment do
    Array(1...19).each do |i|
      Services::TypeService.new.type_repository_response(i)
      puts 'resquesting type and saving to db'
      sleep 1
    end
  end
end

# $ rake types_request:save_types
