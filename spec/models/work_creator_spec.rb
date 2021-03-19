# == Schema Information
#
# Table name: work_creators
#
#  id         :bigint           not null, primary key
#  guest      :boolean          default(FALSE), not null
#  name       :string(255)
#  role       :integer          default("author"), not null
#  xorder     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :bigint
#  work_id    :bigint           not null
#
# Indexes
#
#  index_work_creators_on_creator_id  (creator_id)
#  index_work_creators_on_work_id     (work_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => creators.id)
#  fk_rails_...  (work_id => works.id)
#
require 'rails_helper'

describe WorkCreator, type: :model do
  describe 'validate' do
    subject { work_creator }

    let(:creator) { create :creator }

    context 'valid' do
      context 'guest: true' do
        let(:work_creator) { build :work_creator, guest: true, role: :author, name: '作者' }

        it { is_expected.to be_valid }
      end

      context 'guest: false' do
        let(:work_creator) { build :work_creator, guest: false, role: :author, creator: creator }

        it { is_expected.to be_valid }
      end
    end

    context 'invalid' do
      context 'guest: true' do
        let(:work_creator) { build :work_creator, guest: true, role: nil, name: nil, xorder: nil, creator: creator }

        it do
          aggregate_failures do
            expect(subject).to be_invalid
            expect(subject.errors).to be_of_kind :role, :blank
            expect(subject.errors).to be_of_kind :name, :blank
            expect(subject.errors).to be_of_kind :xorder, :blank
            expect(subject.creator_id).to eq nil
          end
        end
      end

      context 'guest: false' do
        let(:work_creator) { build :work_creator, guest: false, role: nil, name: 'クリエイター', xorder: nil }

        it do
          aggregate_failures do
            expect(subject).to be_invalid
            expect(subject.errors).to be_of_kind :role, :blank
            expect(subject.errors).to be_of_kind :xorder, :blank
            expect(subject.errors).to be_of_kind :creator_id, :blank
            expect(subject.name).to eq nil
          end
        end
      end
    end
  end
end
