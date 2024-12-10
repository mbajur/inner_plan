require "rails_helper"

RSpec.describe 'Tasks management', type: :system, js: true do
  include Devise::Test::IntegrationHelpers

  it "is possible to create a task for list on lists index" do
    sign_in(create(:user))
    list = create(:list)

    visit "/"
    within "#list_#{list.id}" do
      click_link "Add a task"

      fill_in "task[title]", with: "Task title 1"
      find("#task_title").native.send_keys(:enter)
      expect(page).to have_link("Task title 1")

      fill_in "task[title]", with: "Task title 2"
      find("#task_title").native.send_keys(:enter)
      expect(page).to have_link("Task title 2")
    end
  end

  it "is possible to create a task for last group on lists index" do
    sign_in(create(:user))
    group_1 = create(:group)
    group_2 = create(:group, list: group_1.list)

    visit "/"
    within "#list_#{group_1.parent_id}" do
      click_link "Add a task"

      fill_in "task[title]", with: "Task title 1"
      find("#task_title").native.send_keys(:enter)
    end

    within "#list_#{group_2.id}" do
      expect(page).to have_link(group_2.title)
    end
  end

  it "is possible to edit a task" do
    sign_in(create(:user))
    task = create(:task)

    visit "/"
    within "#task_#{task.id}" do
      find('.task-handle').click
      click_link "Edit task"
    end

    find("#task_title").set("Changed title")
    fill_in "task[description]", with: "Changed description"
    click_button "Save changes"

    expect(page).to have_link "Changed title"
    expect(page).to have_content "Changed description"
  end
end
