# == Schema Information
#
# Table name: creator_sites
#
#  id         :bigint           not null, primary key
#  kind       :integer          default("general"), not null
#  name       :string(255)      not null
#  url        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :bigint           not null
#
# Indexes
#
#  index_creator_sites_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => creators.id)
#
require 'rails_helper'

describe CreatorSite, type: :model do
  describe 'validate' do
    subject { creator_site }

    context 'valid' do
      let(:creator_site) { build :creator_site, name: 'ホームページ', kind: :general, url: 'https://example.com' }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      let(:creator_site) { CreatorSite.new(kind: nil) }

      it do
        aggregate_failures do
          expect(subject).to be_invalid
          expect(subject.errors).to be_of_kind :name, :blank
          expect(subject.errors).to be_of_kind :kind, :blank
          expect(subject.errors).to be_of_kind :url, :blank
        end
      end
    end
  end
end
