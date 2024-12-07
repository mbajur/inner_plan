module InnerPlan::Tasks::Show::Items
  class DescriptionComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ClassNames

    def initialize(task:)
      @task = task
    end

    def template
      render(
        InnerPlan::Tasks::Show::ItemComponent.new(icon: Phlex::Icons::Tabler::FileText, title: 'Description') do |c|
          c.with_body do
            if @task.description.present?
              plain description.to_s
            else
              a(
                href: (helpers.edit_task_path(@task, focus: :description)),
                class:
                  (
                    class_names(
                      "text-decoration-none",
                      "text-body-tertiary" => @task.description.blank?,
                      "text-reset" => @task.description.present?
                    )
                  )
              ) { " Click to add description... " }
            end
          end
        end
      )
    end

    private

    def description
      InnerPlan::Tasks::DescriptionRenderer.call(task: @task)[:description]
    end
  end
end
