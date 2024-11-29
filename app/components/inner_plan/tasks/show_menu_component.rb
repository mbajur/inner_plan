module InnerPlan::Tasks
  class ShowMenuComponent < Phlex::HTML
    include Phlex::Rails::Helpers::LinkTo

    def initialize(task)
      @task = task
    end

    def template
      div(class: "dropdown") {
        button(class: "btn btn-link text-reset p-0 opacity-50", data_bs_toggle: "dropdown") {
          render(Phlex::Icons::Tabler::DotsCircleHorizontal.new(width: 35, height: 35))
        }

        ul(class: "dropdown-menu dropdown-menu-end") {
          li {
            link_to(helpers.edit_task_path(@task), class: 'dropdown-item d-flex align-items-center gap-2', data: { turbo_frame: :_top }) {
              render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18, class: 'text-secondary'))
              span { "Edit task" }
            }
          }
        }
      }
    end

    private

    attr_reader :task
  end
end
