require "rails_helper"

RSpec.describe 'Lists management', type: :system, js: true do
  include Devise::Test::IntegrationHelpers

  it "is possible to create a list" do
    sign_in(create(:user))

    visit "/"
    click_link "+ New list"

    fill_in 'list[title]', with: 'List title'
    fill_in 'list[description]', with: 'List description'
    click_button 'Create list'

    expect(page).to have_link('List title')
    expect(page).to have_content('List description')
  end

  it "is possible to update a list" do
    sign_in(create(:user))
    list = create(:list, title: "List to update")

    visit "/"
    click_link "List to update"
    find("#show_menu_list_#{list.id} button").click
    click_link "Edit list"

    fill_in 'list[title]', with: 'Changed title'
    fill_in 'list[description]', with: 'Changed description'
    click_button 'Save'

    expect(page).to have_link('Changed title')
    expect(page).to have_content('Changed description')
  end
end
