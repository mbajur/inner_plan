module InnerPlan::Groups
  class RowsComponent < Phlex::HTML
    def initialize(groups, list:, context: nil)
      @groups = groups
      @list = list
      @context = context
    end

    def template
      div(data: { controller: :groups, tasks_list_id_value: @list.id }) {
        @groups.each do |group|
          render(InnerPlan::Groups::RowComponent.new(group, context: @context))
        end
      }
    end
  end
end
