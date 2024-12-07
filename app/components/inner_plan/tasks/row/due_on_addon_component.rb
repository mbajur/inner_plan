module InnerPlan::Tasks::Row
  class DueOnAddonComponent < BaseAddonComponent
    def render?
      !task.completed? && task.due_on.present?
    end

    def template
      small(class: "text-body-tertiary text-nowrap") {
        render(Phlex::Icons::Tabler::CalendarDue.new(width: 15, height: 15, style: 'margin-top:-3px'))
        span(class: 'ms-1') { task.due_on.strftime('%a, %b %e') }
      }
    end
  end
end
