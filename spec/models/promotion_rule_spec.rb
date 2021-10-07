require 'rails_helper'

RSpec.describe PromotionRule, type: :model do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many :products }
    it { is_expected.to have_and_belong_to_many :carts }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:kind).with_values({ percentage: 1, amount: 2 }).with_suffix(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :type }
  end

  context 'kind is percentage' do
    subject { create :promotion_rule, :percentage }

    describe 'validations' do
      it { is_expected.to validate_presence_of :percentage }
      it { is_expected.to validate_numericality_of :percentage }
    end

    it '#calculated_price' do
      expect(subject.send(:calculated_price, Money.new(10_000))).to eq Money.new(6660)
    end
  end

  context 'kind is amount' do
    subject { create :promotion_rule, :amount }

    describe 'validations' do
      it { is_expected.to validate_presence_of :amount }
      it { is_expected.to validate_numericality_of(:amount) }
    end

    it '#calculated_price' do
      expect(subject.send(:calculated_price, Money.new(10_000))).to eq Money.new(9950)
    end
  end
end
