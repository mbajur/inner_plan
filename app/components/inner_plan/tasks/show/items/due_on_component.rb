module InnerPlan::Tasks::Show::Items
  class DueOnComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ClassNames

    def initialize(task:)
      @task = task
    end

    def template
      render(
        InnerPlan::Tasks::Show::ItemComponent.new(icon: Phlex::Icons::Tabler::CalendarDue, title: 'Due on') do |c|
          c.with_body do
            a(
              href: (helpers.edit_task_path(@task, focus: :due_on)),
              class:
                (
                  class_names(
                    "text-decoration-none",
                    "text-body-tertiary" => @task.due_on.blank?,
                    "text-reset" => @task.due_on.present?
                  )
                )
            ) do
              if @task.due_on
                plain @task.due_on.strftime("%a, %b %e, %Y")
              else
                plain " Select a date... "
              end
            end
          end
        end
      )
    end
  end
end
