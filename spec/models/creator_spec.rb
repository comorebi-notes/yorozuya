# == Schema Information
#
# Table name: creators
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  profile    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

describe Creator, type: :model do
  describe 'validate' do
    subject { creator }

    context 'valid' do
      let(:creator) { build :creator, name: 'ケロ', profile: 'yorozu no mono wo tsukurikeri.' }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      let(:creator) { Creator.new }

      it do
        aggregate_failures do
          expect(subject).to be_invalid
          expect(subject.errors).to be_of_kind :name, :blank
        end
      end
    end
  end
end
