module InnerPlan::Lists
  class ShowView < InnerPlan::ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag

    def initialize(list:)
      @list = list
    end

    def template
      lists = @list.lists.ordered_by_position

      content_tag(:turbo_frame, id: (dom_id(@list, :header))) do
        header do
          render(InnerPlan::BreadcrumbsComponent.new) do |c|
            c.with_breadcrumb do
              link_to "Home", helpers.root_path, class: "text-reset", data: { turbo_frame: :_top }
            end
            c.with_breadcrumb(active: true) { "List ##{@list.id}" }
          end
          div(class: "row") do
            div(class: "col-10") do
              h1(class: "h2") do
                link_to @list.title, helpers.edit_list_path(@list), class: "text-reset text-decoration-none"
                small(class: "fs-6 text-body-tertiary ms-2") do
                  plain @list.tasks.completed.count
                  plain "/"
                  plain @list.tasks.count
                end
              end
            end
            div(class: "col-2 text-end") do
              render(InnerPlan::Lists::ShowMenuComponent.new(@list))
            end
          end
          render(
            InnerPlan::ProgressBarSeparatorComponent.new(
              completed: @list.tasks.completed.count,
              total: @list.tasks.count
            )
          )

          div(class: "mb-4 mt-3") { @list.description }
        end
      end

      render(
      InnerPlan::Lists::OngoingTasksComponent.new(@list, context: :lists_show)
    )

    render(
      InnerPlan::Groups::RowsComponent.new(
        lists.ordered_by_position,
        list: @list,
        context: :lists_show
      )
    )

    last_group = lists.to_a.last || @list

    content_tag(:div, class: "mt-2 mb-4", id: dom_id(last_group, :add_task)) do
      render InnerPlan::Tasks::InlineFormView.new(list: last_group)
    end

    render(
      InnerPlan::Lists::CompletedTasksComponent.new(
        @list,
        context: :lists_show,
        limit: 0
      )
    )
    end
  end
end
