module InnerPlan::Tasks
  class RowsComponent < Phlex::HTML
    include Phlex::Rails::Helpers::DOMID

    def initialize(tasks, list:, context: nil, id_key: :ongoing_tasks)
      @tasks = tasks
      @list = list
      @context = context
      @id_key = id_key
    end

    def template(&content)
      div(id: dom_id(@list, @id_key), data: { controller: :tasks, tasks_list_id_value: @list.id }) {
        @tasks.each do |task|
          render(InnerPlan::Tasks::RowComponent.new(task, context: @context))
        end

        render(content) if content
      }
    end
  end
end
