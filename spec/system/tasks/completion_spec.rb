require "rails_helper"

RSpec.describe 'Tasks management', type: :system, js: true do
  include Devise::Test::IntegrationHelpers

  it "is possible to mark list task as complete" do
    sign_in(create(:user))
    task = create(:task)

    visit "/"
    within "#task_#{task.id}" do
      find("#completion_toggler_task_#{task.id}").click
    end

    within "#completed_tasks_list_#{task.list.id}" do
      expect(page).to have_link(task.title)
    end
  end

  it "is possible to mark group task as complete" do
    sign_in(create(:user))
    list = create(:list)
    group = create(:group, list: list)
    task = create(:task, list: group)

    visit "/"
    within "#task_#{task.id}" do
      find("#completion_toggler_task_#{task.id}").click
    end

    within "#completed_tasks_list_#{task.list.parent_id}" do
      expect(page).to have_link(task.title)
    end
  end
end
