require 'rails_helper'

describe '/admin/works/new', type: :system do
  subject { page }

  let(:subject_path) { new_admin_work_path }
  let!(:creator) { create :creator, name: 'ケロ' }

  before do
    login
    visit subject_path
  end

  context '成功する場合' do
    let(:work) { Work.last }

    before do
      fill_in 'タイトル', with: 'アコゥスティカ'
      select '公開', from: '状態'
      fill_in 'URI', with: 'acoustica'

      select '2021', from: :work_release_date_1i
      select '3', from: :work_release_date_2i
      select '20', from: :work_release_date_3i

      click_link 'クリエイターを追加する'
      within 'legend + .nested-fields' do
        select '作者', from: '役割'
        select 'ケロ', from: 'クリエイター'
        fill_in '順番', with: '0'
      end
      within '.nested-fields + .nested-fields' do
        check 'ゲスト'
        select 'ボーカル', from: '役割'
        fill_in '名前', with: '初音ミク'
        fill_in '順番', with: '1'
      end

      attach_file :work_eye_catch, sample_image, make_visible: true
      find('#work_content').click.set 'ここから始まり、はるか遠くに見える'

      click_button '作品を作成する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_work_path(work)
        expect(page).to have_content '作品を作成しました'
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
        expect(page).to have_content 'いいね 0'
      end
    end
  end

  context '失敗する場合' do
    before { force_submit! }

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_works_path
        expect(page).to have_content 'タイトルを入力してください。'
        expect(page).to have_content 'URIを入力してください。'
        expect(page).to have_content 'クリエイターは1つ以上入力してください。'
      end
    end
  end
end
