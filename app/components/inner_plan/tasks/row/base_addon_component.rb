module InnerPlan::Tasks::Row
  class BaseAddonComponent < Phlex::HTML
    def initialize(task)
      @task = task
    end

    def render?
      true
    end

    def template
      raise NotImplementedError
    end

    private

    attr_reader :task
  end
end
