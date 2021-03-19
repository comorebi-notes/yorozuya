require 'rails_helper'

describe '/admin/works', type: :system do
  subject { page }

  let(:subject_path) { admin_works_path }
  let!(:work) do
    create :work,
           title: 'アコゥスティカ', status: :published, slug: 'acoustica', release_date: Time.zone.local(2021, 3, 20), like: 1000, eye_catch: uploaded_sample_image,
           work_creators: [build(:work_creator, role: :author, creator: creator, xorder: 0),
                           build(:work_creator, :guest, role: :vocal, name: '初音ミク', xorder: 1)]
  end
  let(:creator) { create :creator, name: 'ケロ', icon: uploaded_sample_image }

  before { login }

  describe '作成ボタン' do
    before do
      visit subject_path
      click_link '作成'
    end

    it { is_expected.to have_current_path new_admin_work_path }
  end

  describe '一覧表示' do
    before { visit subject_path }

    it '表示が正しいこと' do
      aggregate_failures do
        within 'main table tbody tr:nth-of-type(1)' do
          expect(find('th:nth-of-type(1)')).to have_content work.id
          expect(find('td:nth-of-type(1)')).to have_selector '.eye-catch--thumb'
          expect(find('td:nth-of-type(1)')).to have_link 'アコゥスティカ', href: admin_work_path(work)
          expect(find('td:nth-of-type(2)')).to have_content '公開'
          expect(find('td:nth-of-type(3)')).to have_content 'acoustica'
          expect(find('td:nth-of-type(4)')).to have_content '2021/3/20'
          expect(find('td:nth-of-type(5)')).to have_content "作者：ケロ\nボーカル：初音ミク"
          expect(find('td:nth-of-type(5)')).to have_link '作者：ケロ', href: admin_creator_path(creator)
          expect(find('td:nth-of-type(6)')).to have_content '1,000'
          expect(find('td:nth-of-type(7)')).to have_link '編集', href: edit_admin_work_path(work)
        end
      end
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
