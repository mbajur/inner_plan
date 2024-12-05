module InnerPlan::Tasks
  class ShowView < ApplicationView
    include Phlex::Rails::Helpers::ClassNames
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes

    attr_reader :task

    def initialize(task:)
      @task = task
    end

    def template
      header(class: "mb-3") do
        render(InnerPlan::BreadcrumbsComponent.new) do |c|
          c.with_breadcrumb do
            link_to "Home", helpers.root_path, class: "text-reset", data: { turbo_frame: :_top }
          end

          if @task.list.list.present?
            c.with_breadcrumb do
              link_to @task.list.list.title, @task.list.list, class: "text-reset"
            end
            c.with_breadcrumb do
              link_to @task.list.title, helpers.group_path(@task.list), class: "text-reset"
            end
          else
            c.with_breadcrumb do
              link_to @task.list.title, @task.list, class: "text-reset"
            end
          end

          c.with_breadcrumb(active: true) { "Task ##{@task.id}" }
        end
      end

      div(class: "d-flex mb-2") do
        div(class: "text-end me-2") do
          div(style: "display:block;margin-top:-0.25rem;margin-left:-0.8rem") do
            render(
              InnerPlan::Tasks::CompletedTogglerComponent.new(
                @task,
                context: :tasks_show,
                size: 39
              )
            )
          end
        end
        div(class: "w-100") do
          h1(class: "h3") do
            link_to @task.title,
                    helpers.edit_task_path(@task, focus: :title),
                    class: "text-reset text-decoration-none"
          end
        end
        div(class: "text-end") do
          render(InnerPlan::Tasks::ShowMenuComponent.new(@task))
        end
      end

      InnerPlan.configuration.task_show_view_rows.each do |row|
        render InnerPlan::Tasks::Form::RowComponent.new do |component|
          row.content.each do |item|
            component.with_column(span: item.options[:span]) do
              render(item.content.call(context: self))
            end
          end
        end
      end
    end

    def description
      InnerPlan::Tasks::DescriptionRenderer.call(task: @task)[:description]
    end
  end
end
