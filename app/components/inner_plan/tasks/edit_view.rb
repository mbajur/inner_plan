module InnerPlan::Tasks
  class EditView < InnerPlan::ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::Debug

    attr_reader :focus

    def initialize(task:, focus: nil)
      @task = task
      @focus = focus&.to_sym
    end

    def template
      header(class: "mb-3") do
        render(InnerPlan::BreadcrumbsComponent.new) do |c|
          c.with_breadcrumb do
            link_to "Home",
                    helpers.root_path,
                    class: "text-reset",
                    data: {
                      turbo_frame: :_top
                    }
          end
          if @task.list.sub?
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
          c.with_breadcrumb do
            link_to "Task ##{@task.id}", @task, class: "text-reset"
          end
          c.with_breadcrumb(active: true) { "Edit" }
        end
      end

      form_with model: @task do |f|
        div(class: "d-flex mb-4") do
          div(class: "text-end me-2 opacity-50") do
            content_tag :a,
                        style:
                          "display:block; margin-top: -0.1rem;margin-left:-0.6rem",
                        data: {
                          turbo: true,
                          turbo_stream: true
                        } do
              render(Phlex::Icons::Tabler::SquareRounded.new(width: 39, height: 39))
            end
          end
          div(class: "w-100") do
            plain f.text_field :title,
                              class: "form-control form-control-lg",
                              autofocus: (@focus == "title")
          end
        end

        InnerPlan.configuration.task_edit_view_rows.each do |row|
          render InnerPlan::Tasks::Form::RowComponent.new do |component|
            row.content.each do |item|
              component.with_column(span: item.options[:span]) do
                render(item.content.call(context: self, form: f))
              end
            end
          end
        end

        plain f.submit "Save changes", class: "btn btn-success btn-sm me-2"
        link_to "Cancel", @task, class: "btn btn-outline-secondary btn-sm"
      end
    end
  end
end
