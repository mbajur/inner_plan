module InnerPlan::Tasks
  class RowComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ClassNames
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::CheckBox

    @@addons = [
      InnerPlan::Tasks::Row::GroupAddonComponent,
      InnerPlan::Tasks::Row::DescriptionAddonComponent,
      InnerPlan::Tasks::Row::DueOnAddonComponent,
      InnerPlan::Tasks::Row::AssigneesAddonComponent,
    ]

    def initialize(task, context: nil)
      @task = task
      @context = context
    end

    def template
      div(class: "d-flex w-100 mb-1", data_id: task.id, data_update_url: helpers.update_position_task_path(task)) {
        div(class: class_names('align-top me-2 text-body-tertiary task-handle cm', invisible: task.completed?), style: 'margin-top:-0.2rem') {
          render(Phlex::Icons::Tabler::GripVertical.new(width: 20, height: 20))
        }

        div(class: 'align-top', style: 'width:2rem; height: 2rem; margin-top: -0.15rem') {
          render(InnerPlan::Tasks::CompletedTogglerComponent.new(task, context: context))
        }

        div(class: class_names('form-check-label ms-0 w-100', 'text-body-tertiary' => task.completed?)) {
          link_to(task.title, task, class: 'text-reset text-decoration-none me-1')

          div(class: 'd-inline-flex align-items-center gap-1') {
            @@addons.each do |addon_class|
              addon_instance = addon_class.new(task)
              next unless addon_instance.render?

              render(addon_instance)
            end
          }
        }
      }
    end

    private

    attr_reader :task, :context
  end
end
