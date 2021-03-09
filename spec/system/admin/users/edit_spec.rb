require 'rails_helper'

describe '/admin/users/new', type: :system do
  subject { page }

  let(:subject_path) { edit_admin_user_path(user) }
  let(:user) { create :user, name: 'comorebi notes', screen_name: 'login_id' }

  before do
    login user
    visit subject_path
  end

  it do
    aggregate_failures do
      expect(page).to have_field '名前', with: 'comorebi notes'
      expect(page).to have_field 'ログインID', with: 'login_id'
    end
  end

  context '成功する場合' do
    before do
      visit subject_path
      fill_in '名前', with: '穂村あかね'
      fill_in 'ログインID', with: 'akane_buzz'
      fill_in 'パスワード', with: 'P@ssw0rd'
      fill_in 'パスワード (確認)', with: 'P@ssw0rd'
      click_button 'ユーザを更新する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_users_path
        expect(page).to have_content 'ユーザを更新しました。'
        expect(page).to have_content '穂村あかね'
        expect(page).to have_content 'akane_buzz'
      end
    end
  end
end
