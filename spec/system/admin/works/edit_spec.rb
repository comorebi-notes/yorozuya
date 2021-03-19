require 'rails_helper'

describe '/admin/works/:id/edit', type: :system do
  subject { page }

  let(:subject_path) { edit_admin_work_path(work) }
  let!(:work) do
    create :work,
           title: 'アコゥスティカ', status: :published, slug: 'acoustica', release_date: Time.zone.local(2021, 3, 20),
           content: 'ここから始まり、はるか遠くに見える', like: 1000, eye_catch: uploaded_sample_image,
           work_creators: [build(:work_creator, role: :author, creator: creator, xorder: 0),
                           build(:work_creator, :guest, role: :vocal, name: '初音ミク', xorder: 1)]
  end
  let(:creator) { create :creator, name: 'comorebi notes' }
  let!(:parent_work) { create :work, title: '大都会ラプソディ' }

  before do
    login
    visit subject_path
  end

  # rubocop:disable RSpec/ExampleLength
  it do
    aggregate_failures do
      expect(page).to have_field 'タイトル', with: 'アコゥスティカ'
      expect(page).to have_select '状態', selected: '公開'
      expect(page).to have_field 'URI', with: 'acoustica'
      expect(page).to have_select :work_release_date_1i, selected: '2021'
      expect(page).to have_select :work_release_date_2i, selected: '3'
      expect(page).to have_select :work_release_date_3i, selected: '20'
      within 'legend + .nested-fields' do
        expect(page).to have_select '役割', selected: '作者'
        expect(page).to have_select 'クリエイター', selected: 'comorebi notes'
        expect(page).to have_field '名前', disabled: true
        expect(page).to have_field '順番', with: '0'
      end
      within 'legend + .nested-fields + input + .nested-fields' do
        expect(page).to have_checked_field 'ゲスト', visible: :all
        expect(page).to have_select '役割', selected: 'ボーカル'
        expect(page).to have_select 'クリエイター', disabled: true
        expect(page).to have_field '名前', with: '初音ミク'
        expect(page).to have_field '順番', with: '1'
      end
      expect(page).to have_selector '.eye-catch--default'
      expect(page).to have_content 'ここから始まり、はるか遠くに見える'
    end
  end
  # rubocop:enable RSpec/ExampleLength

  context '成功する場合' do
    before do
      fill_in 'タイトル', with: '自転車とスケッチブック'
      select '大都会ラプソディ', from: '親作品'
      select '下書き', from: '状態'
      fill_in 'URI', with: 'sketchbook'

      select '2011', from: :work_release_date_1i
      select '5', from: :work_release_date_2i
      select '28', from: :work_release_date_3i

      within 'legend + .nested-fields' do
        find('.fa-times').click
      end
      within 'legend + .nested-fields + input + .nested-fields' do
        uncheck 'ゲスト'
        select '作曲', from: '役割'
        select 'comorebi notes', from: 'クリエイター'
        fill_in '順番', with: '0'
      end

      attach_file :work_eye_catch, sample_image, make_visible: true
      find('#work_content').click.set 'スケッチブックは残りあと何ページ？'

      click_button '作品を更新する'
    end

    it do
      aggregate_failures do
        expect(page).to have_current_path admin_work_path(slug: 'sketchbook')
        expect(page).to have_content '作品を更新しました'
        expect(page).to have_selector '.eye-catch--default'
        expect(page).to have_content 'タイトル 自転車とスケッチブック'
        expect(page).to have_content '親作品 大都会ラプソディ'
        expect(page).to have_link '大都会ラプソディ', href: admin_work_path(parent_work)
        expect(page).to have_content "子作品\nなし"
        expect(page).to have_content '状態 下書き'
        expect(page).to have_content 'URI sketchbook'
        expect(page).to have_content '公開日 2011/5/28'
        expect(page).to have_content "内容\nスケッチブックは残りあと何ページ？"
        expect(page).to have_content "クリエイター\n作曲：comorebi notes"
        expect(page).to have_link '作曲：comorebi notes', href: admin_creator_path(creator)
        expect(page).to have_content 'いいね 1,000'
      end
    end
  end
end
