require 'rails_helper'

describe '/admin', type: :system do
  subject { find('main') }

  before do
    login
    visit admin_root_path
  end

  it { is_expected.to have_content 'admin' }
end
