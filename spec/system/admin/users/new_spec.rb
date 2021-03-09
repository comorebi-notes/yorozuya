require 'rails_helper'

describe '/admin/users/new', type: :system do
  subject { page }

  let(:subject_path) { new_admin_user_path }

  before { login }

  context '成功する場合' do
    before do
      visit subject_path
      fill_in '名前', with: '穂村あかね'
      fill_in 'ログインID', with: 'akane_buzz'
      fill_in 'パスワード', with: 'P@ssw0rd'
      fill_in 'パスワード (確認)', with: 'P@ssw0rd'
      click_button 'ユーザを作成する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_users_path
        expect(page).to have_content 'ユーザを作成しました。'
        expect(page).to have_content '穂村あかね'
        expect(page).to have_content 'akane_buzz'
      end
    end
  end

  context '失敗する場合' do
    before do
      visit subject_path
      click_button 'ユーザを作成する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_users_path
        expect(page).to have_content 'パスワードを入力してください。'
        expect(page).to have_content 'ログインIDを入力してください。'
      end
    end
  end
end
