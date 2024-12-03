module InnerPlan::Tasks::Row
  class AddonsComponent < Phlex::HTML
    @@addons = [
      InnerPlan::Tasks::Row::GroupAddonComponent,
      InnerPlan::Tasks::Row::DescriptionAddonComponent,
      InnerPlan::Tasks::Row::DueOnAddonComponent,
      InnerPlan::Tasks::Row::AssigneesAddonComponent,
    ]

    def initialize(task)
      @task = task
    end

    def template
      div(class: 'd-inline-flex align-items-center gap-1') {
        @@addons.each do |addon_class|
          addon_instance = addon_class.new(task)
          next unless addon_instance.render?

          render(addon_instance)
        end
      }
    end

    private

    attr_reader :task
  end
end
