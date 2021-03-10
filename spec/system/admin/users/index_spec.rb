require 'rails_helper'

describe '/admin/users', type: :system do
  subject { page }

  let(:subject_path) { admin_users_path }
  let(:user) { create :user, name: 'comorebi notes', screen_name: 'login_id' }

  before { login user }

  describe '作成ボタン' do
    before do
      visit subject_path
      click_link '作成'
    end

    it { is_expected.to have_current_path new_admin_user_path }
  end

  describe '一覧表示' do
    before { visit subject_path }

    it '表示が正しいこと' do
      aggregate_failures do
        expect(find('main table tbody tr:nth-of-type(1) th:nth-of-type(1)')).to have_content user.id
        expect(find('main table tbody tr:nth-of-type(1) td:nth-of-type(1)')).to have_content 'comorebi notes'
        expect(find('main table tbody tr:nth-of-type(1) td:nth-of-type(2)')).to have_content 'login_id'
      end
    end

    it '編集ボタンが動作すること' do
      click_link '編集'
      expect(page).to have_current_path edit_admin_user_path(user)
    end
  end

  describe '削除ボタン' do
    let!(:another_user) { create :user, name: 'Another user' }

    before { visit subject_path }

    it 'ログイン中の管理者の場合には表示されないこと' do
      expect(find('main table tbody tr:nth-of-type(1) td:nth-of-type(3)')).not_to have_link '削除'
    end

    it 'ログイン中以外の管理者の場合には表示されること' do
      expect(find('main table tbody tr:nth-of-type(2) td:nth-of-type(3)')).to have_link '削除', href: admin_user_path(another_user)
    end

    it '削除できること' do
      page.accept_confirm { click_link '削除' }
      aggregate_failures do
        expect(page).to have_content '管理者を削除しました'
        expect(page).not_to have_content 'Another user'
      end
    end
  end
end
