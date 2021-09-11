# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::TypeService do
  describe '#type_repository_response' do
    it 'returns a type' do
      type_service = Services::TypeService.new
      type_service.type_repository_response(1)
      expect(Type.first.name).to eq('normal')
    end
  end
end
