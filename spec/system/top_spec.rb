require 'rails_helper'

describe '/', type: :system do
  subject { page }

  before { visit root_path }

  it { is_expected.to have_current_path root_path }
end
