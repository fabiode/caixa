require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many :promotion_rules }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price_cents }
  end

  describe 'Money behavior' do
    it { is_expected.to respond_to :price }
    it { expect(subject.price.class).to eq Money }
  end
end
