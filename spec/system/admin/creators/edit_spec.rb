require 'rails_helper'

describe '/admin/creators/:id/edit', type: :system do
  subject { page }

  let(:subject_path) { edit_admin_creator_path(creator) }
  let!(:creator) { create :creator, name: 'ケロ', profile: 'yorozu no mono wo tsukurikeri.' }

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
      click_button 'クリエイターを更新する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_creator_path(creator)
        expect(page).to have_content 'クリエイターを更新しました'
        expect(page).to have_content '穂村あかね'
        expect(page).to have_content '教えてポヨよん'
      end
    end
  end
end
