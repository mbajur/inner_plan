module InnerPlan::Tasks
  class EditView < ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag
    include Phlex::Rails::Helpers::FormWith

    def initialize(task:, focus: nil)
      @task = task
      @focus = focus
    end

    def template
      header(class: "mb-3") do
        render(InnerPlan::BreadcrumbsComponent.new) do |c|
          c.with_breadcrumb do
            link_to "Home",
                    helpers.root_path,
                    class: "text-reset",
                    data: {
                      turbo_frame: :_top
                    }
          end
          if @task.list.sub?
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
          c.with_breadcrumb do
            link_to "Task ##{@task.id}", @task, class: "text-reset"
          end
          c.with_breadcrumb(active: true) { "Edit" }
        end
      end

      form_with model: @task do |f|
        div(class: "d-flex mb-2") do
          div(class: "text-end me-2 opacity-50") do
            content_tag :a,
                        style:
                          "display:block; margin-top: -0.1rem;margin-left:-0.6rem",
                        data: {
                          turbo: true,
                          turbo_stream: true
                        } do
              render(Phlex::Icons::Tabler::SquareRounded.new(width: 39, height: 39))
            end
          end
          div(class: "w-100") do
            plain f.text_field :title,
                              class: "form-control form-control-lg",
                              autofocus: (@focus == "title")
          end
        end

        div(class: "row") do
          div(class: "col-6") do
            div(class: "d-flex mt-4") do
              div(class: "me-3 text-body-tertiary", style: "margin-top:-.2 rem") do
                render(Phlex::Icons::Tabler::User.new(width: 24, height: 24))
              end
              div(class: "mw-100") do
                h6 { "Assigned to" }
                div(class: "w-100 pe-5") do
                  plain f.combobox :assigned_user_ids,
                                  helpers.users_path,
                                  multiselect_chip_src: helpers.combobox_chips_users_path,
                                  autofocus: (@focus == "assigned_user_ids")
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
                plain f.date_field :due_on,
                                  class: "form-control",
                                  autofocus: (@focus == "due_on")
              end
            end
          end
        end

        div(class: "d-flex mt-4 mb-4") do
          div(class: "me-3 text-body-tertiary", style: "margin-top:-.2 rem") do
            render(Phlex::Icons::Tabler::FileText.new(width: 24, height: 24))
          end
          div(class: "pe-4") do
            h6 { "Description" }
            plain f.rich_textarea :description,
                                  autofocus: (@focus == "description")
          end
        end

        plain f.submit "Save changes", class: "btn btn-success btn-sm"

        link_to "Cancel", @task, class: "btn btn-outline-secondary btn-sm"
      end
    end
  end
end
