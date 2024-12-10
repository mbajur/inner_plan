module InnerPlan::Groups
  class RowComponent < Phlex::HTML
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::DOMID

    def initialize(list, context: nil)
      @list = list
      @context = context
    end

    def template
      div(
        id: dom_id(@list),
        data: { update_url: helpers.update_position_group_path(list), id: list.id }
      ) {
        div(class: 'd-flex w-100 mb-1', style: 'line-height: 1.7rem') {
          render(InnerPlan::Groups::Row::HandleComponent.new(list))

          div(class: "ms-1 w-100") {
            strong {
              link_to(list.title, helpers.group_path(list), class: 'text-reset text-decoration-none')
            }
          }
        }

        render(InnerPlan::Lists::OngoingTasksComponent.new(list, context: context))
      }
    end

    private

    attr_reader :list, :context
  end
end
