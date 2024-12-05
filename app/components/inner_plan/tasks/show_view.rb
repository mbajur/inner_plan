module InnerPlan::Tasks
  class ShowView < ApplicationView
    include Phlex::Rails::Helpers::ClassNames
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes

    def initialize(task:)
      @task = task
    end

    def template
      header(class: "mb-3") do
        render(InnerPlan::BreadcrumbsComponent.new) do |c|
          c.with_breadcrumb do
            link_to "Home", helpers.root_path, class: "text-reset", data: { turbo_frame: :_top }
          end

          if @task.list.list.present?
            c.with_breadcrumb do
              link_to @task.list.list.title, @task.list.list, class: "text-reset"
            end
            c.with_breadcrumb do
              link_to @task.list.title, helpers.group_path(@task.list), class: "text-reset"
            end
          else
            c.with_breadcrumb do
              link_to @task.list.title, @task.list, class: "text-reset"
            end
          end

          c.with_breadcrumb(active: true) { "Task ##{@task.id}" }
        end
      end

      div(class: "d-flex mb-2") do
        div(class: "text-end me-2") do
          div(style: "display:block;margin-top:-.25 rem;margin-left:-.8 rem") do
            render(
              InnerPlan::Tasks::CompletedTogglerComponent.new(
                @task,
                context: :tasks_show,
                size: 39
              )
            )
          end
        end
        div(class: "w-100") do
          h1(class: "h3") do
            link_to @task.title,
                    helpers.edit_task_path(@task, focus: :title),
                    class: "text-reset text-decoration-none"
          end
        end
        div(class: "text-end") do
          render(InnerPlan::Tasks::ShowMenuComponent.new(@task))
        end
      end

      div(class: "row") do
        div(class: "col-6") do
          div(class: "d-flex mt-4") do
            div(class: "me-3 text-body-tertiary", style: "margin-top:-.2 rem") do
              render(Phlex::Icons::Tabler::User.new(width: 24, height: 24))
            end
            div do
              h6 { "Assigned to" }
              if @task.assigned_users.any?
                plain @task.assigned_users.map do |user|
                  render(InnerPlan::UserWithAvatarComponent.new(user))
                end.to_sentence.html_safe
              else
                a(
                  href: (helpers.edit_task_path(@task, focus: :assigned_user_ids)),
                  class: "text-decoration-none text-body-tertiary"
                ) { " Select assignees... " }
              end
            end
          end
        end
        div(class: "col-6") do
          div(class: "d-flex mt-4") do
            div(class: "me-3 text-body-tertiary", style: "margin-top:-.2 rem") do
              render(Phlex::Icons::Tabler::CalendarDue.new(width: 24, height: 24))
            end
            div do
              h6 { "Due on" }
              a(
                href: (helpers.edit_task_path(@task, focus: :due_on)),
                class:
                  (
                    class_names(
                      "text-decoration-none",
                      "text-body-tertiary" => @task.due_on.blank?,
                      "text-reset" => @task.due_on.present?
                    )
                  )
              ) do
                if @task.due_on
                  plain @task.due_on.strftime("%a, %b %e, %Y")
                else
                  plain " Select a date... "
                end
              end
            end
          end
        end
      end

      div(class: "d-flex mt-4") do
        div(class: "me-3 text-body-tertiary", style: "margin-top:-.2 rem") do
          render(Phlex::Icons::Tabler::FileText.new(width: 24, height: 24))
        end
        div(class: "pe-4") do
          h6 { "Description" }
          if @task.description.present?
            plain @task.description.to_s
          else
            a(
              href: (helpers.edit_task_path(@task, focus: :description)),
              class:
                (
                  class_names(
                    "text-decoration-none",
                    "text-body-tertiary" => @task.description.blank?,
                    "text-reset" => @task.description.present?
                  )
                )
            ) { " Click to add description... " }
          end
        end
      end

      div(class: "d-flex mt-4") do
        div(class: "me-3 text-body-tertiary", style: "margin-top:-.2 rem") do
          render(Phlex::Icons::Tabler::CirclePlus.new(width: 24, height: 24))
        end
        div(class: "pe-4") do
          h6 { "Created by" }
          div(class: "text-body-tertiary") do
            render(InnerPlan::UserWithAvatarComponent.new(@task.user))
            plain " on "
            plain @task.created_at.strftime("%a, %b %e, %Y")
          end
        end
      end
    end
  end
end
