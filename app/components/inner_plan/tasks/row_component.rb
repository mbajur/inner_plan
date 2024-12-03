module InnerPlan::Tasks
  class RowComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ClassNames
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::CheckBox

    def initialize(task, context: nil)
      @task = task
      @context = context
    end

    def template
      div(class: "d-flex w-100 mb-1", data: { id: task.id, update_url: helpers.update_position_task_path(task) }) {
        render(InnerPlan::Tasks::Row::HandleComponent.new(task))

        div(class: 'align-top', style: 'width:2rem; height: 2rem; margin-top: -0.15rem') {
          render(InnerPlan::Tasks::CompletedTogglerComponent.new(task, context: context))
        }

        div(class: class_names('form-check-label ms-0 w-100', 'text-body-tertiary' => task.completed?)) {
          link_to(title, task, class: 'text-reset text-decoration-none me-1')
          render(InnerPlan::Tasks::Row::AddonsComponent.new(task))
        }
      }
    end

    private

    attr_reader :task, :context

    def title
      InnerPlan::Tasks::TitleRenderer.call(task: task)[:title]
    end
  end
end
