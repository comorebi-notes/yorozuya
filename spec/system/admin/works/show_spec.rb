require 'rails_helper'

describe '/admin/works/:id', type: :system do
  subject { page }

  let(:subject_path) { admin_work_path(work) }
  let(:work) do
    create :work,
           title: 'アコゥスティカ', status: :published, slug: 'acoustica', release_date: Time.zone.local(2021, 3, 20),
           content: 'ここから始まり、はるか遠くに見える', like: 1000, eye_catch: uploaded_sample_image,
           work_creators: [build(:work_creator, role: :author, creator: creator, xorder: 0),
                           build(:work_creator, :guest, role: :vocal, name: '初音ミク', xorder: 1)]
  end
  let(:creator) { create :creator, name: 'ケロ' }

  before do
    login
    visit subject_path
  end

  it '表示が正しいこと' do
    aggregate_failures do
      expect(page).to have_link '編集', href: edit_admin_work_path(work)
      expect(page).to have_content "ID #{work.id}"
      expect(page).to have_selector '.eye-catch--default'
      expect(page).to have_content 'タイトル アコゥスティカ'
      expect(page).to have_content "親作品\nなし"
      expect(page).to have_content "子作品\nなし"
      expect(page).to have_content '状態 公開'
      expect(page).to have_content 'URI acoustica'
      expect(page).to have_content '公開日 2021/3/20'
      expect(page).to have_content "内容\nここから始まり、はるか遠くに見える"
      expect(page).to have_content "クリエイター\n作者：ケロ\nボーカル：初音ミク"
      expect(page).to have_link '作者：ケロ', href: admin_creator_path(creator)
      expect(page).to have_content 'いいね 1,000'
    end
  end

  describe '削除ボタン' do
    before { visit subject_path }

    it '削除できること' do
      page.accept_confirm { click_link '削除' }
      aggregate_failures do
        expect(page).to have_content '作品を削除しました'
        expect(page).not_to have_content 'アコゥスティカ'
      end
    end
  end
end
