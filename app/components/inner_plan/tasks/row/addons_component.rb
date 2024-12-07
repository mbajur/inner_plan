module InnerPlan::Tasks::Row
  class AddonsComponent < Phlex::HTML
    def initialize(task)
      @task = task
    end

    def template
      div(class: 'd-inline-flex align-items-center gap-1') {
        InnerPlan.configuration.task_row_addons.each do |item|
          addon_instance = item.content.constantize.new(task)
          next unless addon_instance.render?

          render(addon_instance)
        end
      }
    end

    private

    attr_reader :task
  end
end
