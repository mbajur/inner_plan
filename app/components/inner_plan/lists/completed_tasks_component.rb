module InnerPlan::Lists
  class CompletedTasksComponent < Phlex::HTML
    def initialize(list, limit: 3, context: nil)
      @list = list
      @limit = limit
      @context = context
    end

    def template
      truncate = @limit.positive?
      scope = @list.root? ? @list.tasks_including_groups : @list.tasks
      scope = scope.completed
      scope = truncate ? scope.limit(@limit) : scope

      render InnerPlan::Tasks::RowsComponent.new(scope, list: @list, context: context, id_key: :completed_tasks) do
        if truncate
          completed_tasks_count = @list.tasks.completed.count

          if (completed_tasks_count - @limit).positive?
            div(class: "mt-2 ms-tasks-element") {
              a(href: helpers.list_path(@list, anchor: :completed), class: "text-body-tertiary") {
                plain "And #{completed_tasks_count - @limit} more completed to-dos..."
              }
            }
          end
        end
      end
    end
  end
end
