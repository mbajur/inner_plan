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
      div(class: "d-flex w-100 align-items-start", data: { id: task.id, update_url: helpers.update_position_task_path(task) }) {
        render(InnerPlan::Tasks::Row::HandleComponent.new(task))

        div(class: 'align-top', style: 'width:2rem; height: 2rem; line-height: 1.6rem;') {
          render(InnerPlan::Tasks::CompletedTogglerComponent.new(task, context: context))
        }

        div(class: class_names('form-check-label ms-1 w-100', 'text-body-tertiary' => task.completed?), style: 'line-height: 1.6rem; padding-top: 1px;') {
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
