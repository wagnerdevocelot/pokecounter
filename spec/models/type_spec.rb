# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Type, type: :model do
  subject(:type) { build(:type) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:pokemon_a) }
  it { should have_many(:pokemon_b) }
  it { is_expected.to be_valid }
end
