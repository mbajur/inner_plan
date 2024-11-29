module InnerPlan::Tasks::Row
  class GroupAddonComponent < BaseAddonComponent
    def render?
      @task.completed? && !@task.group.default?
    end

    def template
      plain " &mdash; ".html_safe + @task.group.title
    end
  end
end
