module InnerPlan
  module ApplicationHelper
    def percent(count, total)
      count.to_f / total.to_f * 100.0
    end
  end
end
