require 'rails_helper'

describe '/admin/creators/:id/edit', type: :system do
  subject { page }

  let(:subject_path) { edit_admin_creator_path(creator) }
  let!(:creator) { create :creator, name: 'ケロ', profile: 'yorozu no mono wo tsukurikeri.', icon: Rack::Test::UploadedFile.new('spec/support/files/icon.png', 'image/png') }

  before do
    login
    visit subject_path
  end

  it do
    aggregate_failures do
      expect(page).to have_field '名前', with: 'ケロ'
      expect(page).to have_field 'プロフィール', with: 'yorozu no mono wo tsukurikeri.'
    end
  end

  context '成功する場合' do
    before do
      visit subject_path
      fill_in '名前', with: '穂村あかね'
      fill_in 'プロフィール', with: '教えてポヨよん'
      check '現在のアイコンを削除する'
      click_button 'クリエイターを更新する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_creator_path(creator)
        expect(page).to have_content 'クリエイターを更新しました'
        expect(page).not_to have_selector '.icon--default'
        expect(page).to have_content '名前 穂村あかね'
        expect(page).to have_content 'プロフィール 教えてポヨよん'
      end
    end
  end
end
