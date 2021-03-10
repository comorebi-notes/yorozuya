require 'rails_helper'

describe '/admin/login', type: :system do
  subject { page }

  let(:subject_path) { admin_login_path }

  describe 'ログイン' do
    context 'ログインしていない場合' do
      before { create :user, name: 'comorebi notes', screen_name: 'login_id', password: 'P@ssw0rd', password_confirmation: 'P@ssw0rd' }

      context 'ログインに成功する場合' do
        before do
          visit subject_path
          fill_in 'ログインID', with: 'login_id'
          fill_in 'パスワード', with: 'P@ssw0rd'
          click_button 'ログインする'
        end

        it do
          aggregate_failures do
            expect(page).to have_current_path admin_root_path
            expect(page).to have_content 'ログインしました'
            expect(find('.navbar')).to have_content 'comorebi notes'
          end
        end
      end

      context 'ログインに失敗する場合' do
        before do
          visit subject_path
          fill_in 'ログインID', with: 'failed_login_id'
          fill_in 'パスワード', with: 'P@ssw0rd'
          click_button 'ログインする'
        end

        it do
          aggregate_failures do
            expect(page).to have_current_path admin_login_path
            expect(page).to have_content 'IDもしくはパスワードが違います'
            expect(find('.navbar')).not_to have_content 'comorebi notes'
          end
        end
      end
    end

    context 'ログインしている場合' do
      before do
        login create(:user, name: 'comorebi notes')
        visit subject_path
      end

      it do
        aggregate_failures do
          expect(page).to have_current_path admin_root_path
          expect(page).to have_content 'すでにログインしています'
          expect(find('.navbar')).to have_content 'comorebi notes'
        end
      end
    end
  end

  describe 'ログアウト' do
    before do
      login create(:user, name: 'comorebi notes')
      click_link 'ログアウト'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_login_path
        expect(page).to have_content 'ログアウトしました'
        expect(find('.navbar')).not_to have_content 'comorebi notes'
      end
    end
  end
end
