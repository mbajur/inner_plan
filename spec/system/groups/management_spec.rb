require "rails_helper"

RSpec.describe 'Groups management', type: :system, js: true do
  include Devise::Test::IntegrationHelpers

  it "is possible to create a group" do
    sign_in(create(:user))
    list = create(:list)

    visit "/"
    within "#list_#{list.id}" do
      find(".list-handle").click
      click_link "Add group"
    end

    fill_in 'list[title]', with: 'Group title'
    fill_in 'list[description]', with: 'Group description'
    click_button 'Save changes'

    expect(page).to have_link('Group title')
  end

  it "is possible to update a group" do
    sign_in(create(:user))
    group = create(:group, title: "Group to update")

    visit "/"
    within "#list_#{group.id}" do
      find(".group-handle").click
      click_link "Edit group"
    end

    fill_in 'list[title]', with: 'Changed title'
    fill_in 'list[description]', with: 'Changed description'
    click_button 'Save'

    expect(page).to have_link('Changed title')
    expect(page).to have_content('Changed description')
  end
end
