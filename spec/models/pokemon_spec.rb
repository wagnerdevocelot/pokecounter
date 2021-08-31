# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  subject(:pokemon) { build(:pokemon) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type_a_id) }
    it { should validate_presence_of(:hp) }
    it { should validate_presence_of(:attack) }
    it { should validate_presence_of(:defense) }
    it { should validate_presence_of(:special_attack) }
    it { should validate_presence_of(:special_defense) }
    it { should validate_presence_of(:speed) }
    it { should validate_presence_of(:generation) }
    it { should belong_to(:type_a) }
    it { is_expected.to be_valid }
  end
end
