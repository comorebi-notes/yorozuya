require 'rails_helper'

describe '/admin/creators/:id/edit', type: :system do
  subject { page }

  let(:subject_path) { edit_admin_creator_path(creator) }
  let!(:creator) do
    create :creator,
           name: 'ケロ', profile: 'yorozu no mono wo tsukurikeri.', icon: uploaded_sample_image,
           creator_sites: [build(:creator_site, name: 'ホームページ', kind: :homepage, url: 'https://example.com')]
  end

  before do
    login
    visit subject_path
  end

  it do
    aggregate_failures do
      within 'form > div:first-of-type' do
        expect(page).to have_field '名前', with: 'ケロ'
      end
      expect(page).to have_field 'プロフィール', with: 'yorozu no mono wo tsukurikeri.'
      expect(page).to have_selector '.icon--default'
      within 'legend + .nested-fields' do
        expect(page).to have_field '名前', with: 'ホームページ'
        expect(page).to have_select '種類', selected: 'ホームページ'
        expect(page).to have_field 'URL', with: 'https://example.com'
      end
    end
  end

  context '成功する場合' do
    before do
      visit subject_path
      within 'form > div:first-of-type' do
        fill_in '名前', with: '穂村あかね'
      end
      fill_in 'プロフィール', with: '教えてポヨよん'
      check '現在のアイコンを削除する'
      within '.nested-fields ~ .nested-fields' do
        select 'Twitter', from: '種類'
        fill_in 'URL', with: 'https://twitter.com/tos'
        fill_in '名前', with: '@tos'
      end
      click_button 'クリエイターを更新する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_creator_path(creator)
        expect(page).to have_content 'クリエイターを更新しました'
        expect(page).not_to have_selector '.icon--default'
        expect(page).to have_content '名前 穂村あかね'
        expect(page).to have_content 'プロフィール 教えてポヨよん'
        expect(page).to have_content "リンク\nホームページ\n@tos"
        expect(page).to have_link 'ホームページ', href: 'https://example.com'
        expect(page).to have_link '@tos', href: 'https://twitter.com/tos'
      end
    end
  end
end
