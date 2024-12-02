module InnerPlan::Tasks::Row
  class GroupAddonComponent < BaseAddonComponent
    def render?
      @task.completed? && @task.list.sub?
    end

    def template
      plain " &mdash; ".html_safe + @task.list.title
    end
  end
end
