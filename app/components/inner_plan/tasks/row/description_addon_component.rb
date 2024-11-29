module InnerPlan::Tasks::Row
  class DescriptionAddonComponent < BaseAddonComponent
    def render?
      !task.completed? && task.description.present?
    end

    def template
      span(class: "text-body-tertiary d-inline-flex align-items-center") {
        render(Phlex::Icons::Tabler::FileText.new(width: 15, height: 15))
      }
    end
  end
end
