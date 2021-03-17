# == Schema Information
#
# Table name: works
#
#  id           :bigint           not null, primary key
#  like         :integer          default(0), not null
#  release_date :date             not null
#  slug         :string(255)      not null
#  status       :integer          default("draft"), not null
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  work_id      :bigint
#
# Indexes
#
#  index_works_on_slug     (slug) UNIQUE
#  index_works_on_work_id  (work_id)
#
# Foreign Keys
#
#  fk_rails_...  (work_id => works.id)
#
require 'rails_helper'

describe Work, type: :model do
  describe 'validate' do
    subject { work }

    let(:creator) { create :creator }

    context 'valid' do
      let(:work) do
        build :work,
              title: '作品', status: :published, slug: :work, release_date: Time.zone.today, like: 0,
              work_creators: [build(:work_creator, creator: creator)]
      end

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      let(:work) { Work.new(status: nil, like: nil) }

      it do
        aggregate_failures do
          expect(subject).to be_invalid
          expect(subject.errors).to be_of_kind :title, :blank
          expect(subject.errors).to be_of_kind :status, :blank
          expect(subject.errors).to be_of_kind :slug, :blank
          expect(subject.errors).to be_of_kind :release_date, :blank
          expect(subject.errors).to be_of_kind :work_creators, :too_short
        end
      end

      describe 'slug' do
        let(:work) { Work.new(slug: :work) }

        before { create :work, slug: :work }

        it do
          aggregate_failures do
            expect(subject).to be_invalid
            expect(subject.errors).to be_of_kind :slug, :taken
          end
        end
      end
    end
  end
end
