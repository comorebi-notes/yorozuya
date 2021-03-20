require 'rails_helper'

describe '/admin/creators/new', type: :system do
  subject { page }

  let(:subject_path) { new_admin_creator_path }

  before do
    login
    visit subject_path
  end

  context '成功する場合' do
    let(:creator) { Creator.last }

    before do
      within 'form > div:first-of-type' do
        fill_in '名前', with: '穂村あかね'
      end
      fill_in 'プロフィール', with: '教えてポヨよん'
      attach_file :creator_icon, sample_image, make_visible: true
      click_link 'リンクを追加する'
      within 'legend + .nested-fields' do
        select 'Twitter', from: '種類'
        fill_in 'URL', with: 'https://twitter.com/tos'
        fill_in '名前', with: '@tos'
        fill_in '順番', with: '1'
      end
      within 'legend + .nested-fields + .nested-fields' do
        select 'ホームページ', from: '種類'
        fill_in 'URL', with: 'https://example.com'
        fill_in '名前', with: 'ホームページ'
        fill_in '順番', with: '0'
      end
      click_button 'クリエイターを作成する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_creator_path(creator)
        expect(page).to have_content 'クリエイターを作成しました'
        expect(page).to have_selector '.icon--default'
        expect(page).to have_content '名前 穂村あかね'
        expect(page).to have_content 'プロフィール 教えてポヨよん'
        expect(page).to have_content "リンク\nホームページ\n@tos"
        expect(page).to have_link 'ホームページ', href: 'https://example.com'
        expect(page).to have_link '@tos', href: 'https://twitter.com/tos'
      end
    end
  end

  context '失敗する場合' do
    before { force_submit! }

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_creators_path
        expect(page).to have_content '名前を入力してください。'
      end
    end
  end
end
