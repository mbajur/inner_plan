require "rails_helper"

RSpec.describe 'Searching', type: :system, js: true do
  include Devise::Test::IntegrationHelpers

  it "is search for a task using dropdown search" do
    create(:task, title: 'foo')
    create(:task, title: 'bar')
    create(:task, title: 'baz')

    visit "/"
    within "#nav-main" do
      click_link 'Find'

      fill_in 'q', with: 'bar'
      find("[name='q']").native.send_keys(:enter)

      expect(page).not_to(have_link('foo'))
      expect(page).to(have_link('bar'))
      expect(page).not_to(have_link('baz'))
    end
  end
end
