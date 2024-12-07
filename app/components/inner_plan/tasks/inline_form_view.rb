module InnerPlan::Tasks
  class InlineFormView < InnerPlan::ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag
    include Phlex::Rails::Helpers::FormWith

    def initialize(task: InnerPlan::Task.new, list:, form_visible: false)
      @task = task
      @list = list
      @form_visible = form_visible
    end

    def template
      div(
        data_controller: "task-inline-form",
        data_task_inline_form_form_visible_value:
          (@form_visible == true)
      ) do
        form_with model: @task,
                  url: helpers.list_tasks_path(@list),
                  class: ("d-none" if @form_visible != true),
                  data: {
                    task_inline_form_target: :form
                  } do |f|
          div(class: "d-flex w-100 mb-1") do
            div(
              class: "align-top me-2 text-muted invisible",
              style: "margin-top:-.05 rem"
            ) do
              render(Phlex::Icons::Tabler::GripVertical.new(width: 20, height: 20))
            end
            div(
              class: "align-top me-2",
              style: "width:2 rem;height:2 rem;margin-top:-.12 rem"
            ) do
              button(class: "btn p-0 opacity-50") do
                render(Phlex::Icons::Tabler::SquareRounded.new(width: 24, height: 24))
              end
            end
            div(class: "form-check-label ms-1 w-100") do
              plain f.text_field :title,
                                autocomplete: "off",
                                class: "form-control w-100",
                                data: {
                                  task_inline_form_target: :defaultInput,
                                  action: "keydown.esc->task-inline-form#escPressed"
                                }
            end
          end
        end
        a(
          href: "#",
          data_action: "task-inline-form#togglerClicked",
          data_task_inline_form_target: "toggler",
          class: "btn btn-outline-secondary btn-sm ms-tasks-element"
        ) { " Add a task " }
      end
    end
  end
end
