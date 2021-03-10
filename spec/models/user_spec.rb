# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  remember_token  :string(255)
#  screen_name     :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_screen_name  (screen_name) UNIQUE
#
require 'rails_helper'

describe User, type: :model do
  describe 'validate' do
    subject { user }

    context 'valid' do
      let(:user) { build :user, name: 'comorebi notes', screen_name: 'login_id', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd' }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      let(:user) { User.new }

      it do
        aggregate_failures do
          expect(subject).to be_invalid
          expect(subject.errors).to be_of_kind :screen_name, :blank
          expect(subject.errors).to be_of_kind :password, :blank
        end
      end
    end
  end
end
