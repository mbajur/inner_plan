module InnerPlan::Lists
  class OngoingTasksComponent < Phlex::HTML
    def initialize(list, context: nil)
      @list = list
      @context = context
    end

    def template
      tasks = @list.tasks.ongoing.ordered_by_position
      render(
        InnerPlan::Tasks::RowsComponent.new(tasks, list: @list,
                                                   context: @context,
                                                   id_key: :ongoing_tasks)
      )
    end
  end
end
