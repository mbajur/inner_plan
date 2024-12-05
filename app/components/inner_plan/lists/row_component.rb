module InnerPlan::Lists
  class RowComponent < Phlex::HTML
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::DOMID

    def initialize(list, context: nil)
      @list = list
      @context = context
    end

    def template
      lists = list.lists.ordered_by_position

      div(data: { update_url: helpers.update_position_list_path(list), id: list.id }, class: "mb-5") {
        div(class: "d-flex w-100 mb-1") {
          render(InnerPlan::Lists::Row::HandleComponent.new(list))

          div(class: "ms-1 w-100") {
            small(class: "text-body-tertiary") {
              plain("#{list.tasks.completed.count}/#{list.tasks.count} completed")
            }

            h3(class: "h5") {
              link_to list.title, list, class: 'text-reset'
            }

            if list.description.present?
              div(class: "mb-2") {
                list.description
              }
            end
          }
        }

        # Ongoing tasks
        render(InnerPlan::Lists::OngoingTasksComponent.new(list, context: context))

        # Groups
        render(InnerPlan::Groups::RowsComponent.new(lists, list: list, context: context))

        # Add new task form
        last_group = lists.to_a.last || list
        div(class: "mt-2 mb-4", id: dom_id(last_group, :add_task)) {
          render InnerPlan::Tasks::InlineFormView.new(list: last_group)
        }

        render(InnerPlan::Lists::CompletedTasksComponent.new(list, context: context))
      }
    end

    private

    attr_reader :list, :context
  end
end
