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

  describe '作品一覧' do
    context '存在する場合' do
      subject { find('h2 + .table-responsive') }

      before do
        create :work, title: 'comorebi', work_creators: [build(:work_creator, role: :author, creator: creator)]
        visit subject_path
      end

      it do
        aggregate_failures do
          expect(subject).to have_content 'comorebi'
          expect(subject).to have_content '作者：ケロ'
        end
      end
    end

    context '存在しない場合' do
      before { visit subject_path }

      it { is_expected.not_to have_selector 'h2 + .table-responsive' }
    end
  end
end
