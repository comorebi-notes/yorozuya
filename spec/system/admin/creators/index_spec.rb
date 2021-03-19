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
        within 'main table tbody tr:nth-of-type(1)' do
          expect(find('th:nth-of-type(1)')).to have_content creator.id
          expect(find('td:nth-of-type(1)')).to have_selector '.icon--thumb'
          expect(find('td:nth-of-type(2)')).to have_link 'ケロ', href: admin_creator_path(creator)
          expect(find('td:nth-of-type(3)')).to have_content 'yorozu no mono wo tsukurikeri.'
          expect(find('td:nth-of-type(4)')).to have_link 'ホームページ', href: 'https://example.com'
          expect(find('td:nth-of-type(5)')).to have_link '編集', href: edit_admin_creator_path(creator)
        end
      end
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
