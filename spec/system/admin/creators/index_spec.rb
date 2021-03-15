require 'rails_helper'

describe '/admin/creators', type: :system do
  subject { page }

  let(:subject_path) { admin_creators_path }
  let!(:creator) do
    create :creator,
           name: 'ケロ', profile: 'yorozu no mono wo tsukurikeri.', icon: uploaded_sample_image,
           creator_sites: [build(:creator_site, name: 'ホームページ', kind: :homepage, url: 'https://example.com')]
  end

  before { login }

  describe '作成ボタン' do
    before do
      visit subject_path
      click_link '作成'
    end

    it { is_expected.to have_current_path new_admin_creator_path }
  end

  describe '一覧表示' do
    before { visit subject_path }

    it '表示が正しいこと' do
      aggregate_failures do
        expect(find('main table tbody tr:nth-of-type(1) th:nth-of-type(1)')).to have_content creator.id
        expect(find('main table tbody tr:nth-of-type(1) td:nth-of-type(1)')).to have_selector '.icon--thumb'
        expect(find('main table tbody tr:nth-of-type(1) td:nth-of-type(2)')).to have_content 'ケロ'
        expect(find('main table tbody tr:nth-of-type(1) td:nth-of-type(3)')).to have_content 'yorozu no mono wo tsukurikeri.'
        expect(find('main table tbody tr:nth-of-type(1) td:nth-of-type(4)')).to have_link 'ホームページ', href: 'https://example.com'
      end
    end

    it '詳細ページに遷移すること' do
      click_link 'ケロ'
      expect(page).to have_current_path admin_creator_path(creator)
    end

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
