require 'rails_helper'

describe '/admin/creators/:id/edit', type: :system do
  subject { page }

  let(:subject_path) { edit_admin_creator_path(creator) }
  let!(:creator) do
    create :creator,
           name: 'ケロ', profile: 'yorozu no mono wo tsukurikeri.', icon: uploaded_sample_image,
           creator_sites: [build(:creator_site, name: 'ホームページ', kind: :homepage, url: 'https://example.com', xorder: 0),
                           build(:creator_site, name: '@tos', kind: :twitter, url: 'https://twitter.com/tos', xorder: 1)]
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
        expect(page).to have_select '種類', selected: 'ホームページ'
        expect(page).to have_field 'URL', with: 'https://example.com'
        expect(page).to have_field '名前', with: 'ホームページ'
        expect(page).to have_field '順番', with: '0'
      end
      within 'legend + .nested-fields + input + .nested-fields' do
        expect(page).to have_select '種類', selected: 'Twitter'
        expect(page).to have_field 'URL', with: 'https://twitter.com/tos'
        expect(page).to have_field '名前', with: '@tos'
        expect(page).to have_field '順番', with: '1'
      end
    end
  end

  context '成功する場合' do
    before do
      within 'form > div:first-of-type' do
        fill_in '名前', with: '穂村あかね'
      end
      fill_in 'プロフィール', with: '教えてポヨよん'
      check '現在のアイコンを削除する'
      within 'legend + .nested-fields' do
        find('.fa-times').click
      end
      within 'legend + .nested-fields + input + .nested-fields' do
        select '一般サイト', from: '種類'
        fill_in 'URL', with: 'https://comore.bi'
        fill_in '名前', with: '公式サイト'
        fill_in '順番', with: '0'
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
        expect(page).to have_content "リンク\n公式サイト"
        expect(page).to have_link '公式サイト', href: 'https://comore.bi'
      end
    end
  end
end
