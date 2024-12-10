module InnerPlan::Lists
  class EditView < InnerPlan::ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag
    include Phlex::Rails::Helpers::FormWith

    def initialize(list:)
      @list = list
    end

    def template
      content_tag(:turbo_frame, id: dom_id(@list, :header)) do
        form_with model: @list do |f|
          header(class: "mb-3") do
            nav(style: "--bs-breadcrumb-divider: '›';") do
              ol(class: "breadcrumb mb-0") do
                li(class: "breadcrumb-item text-body-tertiary") do
                  a(href: helpers.root_path, class: "text-reset", data_turbo_frame: "_top") do
                    "Home"
                  end
                end
                li(class: "breadcrumb-item text-body-tertiary") do
                  link_to "List ##{@list.id}", @list, class: "text-reset"
                end
                li(class: "breadcrumb-item active text-body-tertiary") do
                  "Edit"
                end
              end
            end
            div(class: "row") do
              div(class: "col-6") do
                h1(class: "h2") do
                  plain f.text_field :title,
                                    class: "form-control form-control-lg mt-2"
                end
              end
            end
            render(
              InnerPlan::ProgressBarSeparatorComponent.new(
                completed: @list.tasks.completed.count,
                total: @list.tasks.count
              )
            )
          end

          InnerPlan.configuration.list_edit_view_rows.each do |row|
            render InnerPlan::Tasks::Form::RowComponent.new do |component|
              row.content.each do |item|
                component.with_column(span: item.options[:span]) do
                  render(item.content.constantize.new(form: f))
                end
              end
            end
          end

          div(class: "mb-5") do
            plain f.submit "Save changes", class: "btn btn-success btn-sm"
            link_to "Cancel", @list, class: "btn btn-outline-secondary btn-sm ms-2"
          end
        end
      end
    end
  end
end
