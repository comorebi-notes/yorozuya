require 'rails_helper'

describe '/admin/creators/new', type: :system do
  subject { page }

  let(:subject_path) { new_admin_creator_path }

  before { login }

  context '成功する場合' do
    before do
      visit subject_path
      within 'form > div:first-of-type' do
        fill_in '名前', with: '穂村あかね'
      end
      fill_in 'プロフィール', with: '教えてポヨよん'
      attach_file :creator_icon, sample_image, make_visible: true
      within '.nested-fields' do
        select 'ホームページ', from: '種類'
        fill_in 'URL', with: 'https://example.com'
        fill_in '名前', with: 'ホームページ'
      end
      click_button 'クリエイターを作成する'
    end

    let(:creator) { Creator.last }

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_creator_path(creator)
        expect(page).to have_content 'クリエイターを作成しました'
        expect(page).to have_selector '.icon--default'
        expect(page).to have_content '名前 穂村あかね'
        expect(page).to have_content 'プロフィール 教えてポヨよん'
        expect(page).to have_content "リンク\nホームページ"
        expect(page).to have_link 'ホームページ', href: 'https://example.com'
      end
    end
  end

  context '失敗する場合' do
    before do
      visit subject_path
      force_submit!
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_creators_path
        expect(page).to have_content '名前を入力してください。'
      end
    end
  end
end
