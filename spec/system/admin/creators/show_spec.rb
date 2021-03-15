require 'rails_helper'

describe '/admin/creators/:id', type: :system do
  subject { page }

  let(:subject_path) { admin_creator_path(creator) }
  let!(:creator) do
    create :creator,
           name: 'ケロ', profile: 'yorozu no mono wo tsukurikeri.', icon: uploaded_sample_image,
           creator_sites: [build(:creator_site, name: 'ホームページ', kind: :homepage, url: 'https://example.com')]
  end

  before do
    login
    visit subject_path
  end

  describe '詳細' do
    it '表示が正しいこと' do
      aggregate_failures do
        expect(page).to have_content "ID #{creator.id}"
        expect(page).to have_selector '.icon--default'
        expect(page).to have_content '名前 ケロ'
        expect(page).to have_content 'プロフィール yorozu no mono wo tsukurikeri.'
        expect(page).to have_content "リンク\nホームページ"
        expect(page).to have_link 'ホームページ', href: 'https://example.com'
      end
    end
  end

  describe '編集ボタン' do
    it '編集ボタンが動作すること' do
      click_link '編集'
      expect(page).to have_current_path edit_admin_creator_path(creator)
    end
  end

  describe '削除ボタン' do
    before { visit subject_path }

    it '削除できること' do
      page.accept_confirm { click_link '削除' }
      aggregate_failures do
        expect(page).to have_content 'クリエイターを削除しました'
        expect(page).not_to have_content 'ケロ'
      end
    end
  end
end
