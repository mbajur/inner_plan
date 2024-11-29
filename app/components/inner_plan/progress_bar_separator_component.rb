module InnerPlan
  class ProgressBarSeparatorComponent < Phlex::HTML
    def initialize(completed: 0, total: 100)
      @completed = completed
      @total = total
    end

    def template
      div(class: 'progress mt-2', style: 'height: 2px;') {
        div(class: 'progress-bar bg-success', style: "width: #{completion_percent}%")
      }
    end

    private

    def completion_percent
      @completed.to_f / @total.to_f * 100.0
    end
  end
end
