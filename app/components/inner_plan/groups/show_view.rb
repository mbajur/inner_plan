module InnerPlan::Groups
  class ShowView < ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag

    def initialize(group:)
      @group = group
    end

    def template
      content_tag(:turbo_frame, id: dom_id(@group, :header)) do
        header do
          render(InnerPlan::BreadcrumbsComponent.new) do |c|
            c.with_breadcrumb do
              link_to "Home",
                      helpers.root_path,
                      class: "text-reset",
                      data: {
                        turbo_frame: :_top
                      }
            end
            c.with_breadcrumb(active: true) do
              link_to @group.list.title,
                      @group.list,
                      class: "text-reset",
                      data: {
                        turbo_frame: :_top
                      }
            end
          end
          div(class: "row") do
            div(class: "col-10") do
              h1(class: "h2") do
                link_to @group.title,
                        helpers.edit_group_path(@group),
                        class: "text-reset text-decoration-none me-2"
                small(class: "fs-6 text-body-tertiary") do
                  plain @group.tasks.completed.count
                  plain "/"
                  plain @group.tasks.count
                end
              end
            end
            div(class: "col-2 text-end") do
              render(InnerPlan::Groups::ShowMenuComponent.new(@group))
            end
          end
          render(
            InnerPlan::ProgressBarSeparatorComponent.new(
              completed: @group.tasks.completed.count,
              total: @group.tasks.count
            )
          )
        end
        div(class: "mb-4 mt-3") { @group.description }
      end

      render(
        InnerPlan::Lists::OngoingTasksComponent.new(@group, context: :groups_show)
      )

      content_tag(:div, class: "mt-2 mb-4", id: dom_id(@group, :add_task)) do
        render InnerPlan::Tasks::InlineFormView.new(list: @group)
      end

      render(
        InnerPlan::Lists::CompletedTasksComponent.new(
          @group,
          context: :groups_show,
          limit: 0
        )
      )
    end
  end
end
