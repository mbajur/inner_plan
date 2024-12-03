module InnerPlan::Tasks::Row
  class HandleComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ClassNames
    include Phlex::Rails::Helpers::LinkTo

    def initialize(task)
      @task = task
    end

    def template
      div(
        class: class_names('align-top me-2 text-body-tertiary task-handle cm', invisible: task.completed?),
        style: 'margin-top:-0.2rem'
      ) {
        div(class: "dropstart", style: 'padding-top: 0.1rem') {
          a(class: "align-top text-body-tertiary task-handle cm", data_bs_toggle: "dropdown") {
            render(Phlex::Icons::Tabler::GripVertical.new(width: 20, height: 20))
          }

          ul(class: "dropdown-menu dropdown-menu-end") {
            li {
              link_to(
                helpers.edit_task_path(task),
                class: 'dropdown-item d-flex align-items-center gap-2',
                data: { turbo_frame: :_top }
              ) {
                render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18, class: 'text-secondary'))
                span { "Edit task" }
              }
            }
          }
        }
      }
    end

    private

    attr_reader :task
  end
end
