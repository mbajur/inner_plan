module InnerPlan::Lists
  class NewView < InnerPlan::ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag
    include Phlex::Rails::Helpers::FormWith

    def initialize(list:)
      @list = list
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
        end
        div(class: "row") { div(class: "col-6") { h1(class: "h2") { "New list" } } }
        render(InnerPlan::ProgressBarSeparatorComponent.new)
      end

      form_with model: @list do |f|
        plain f.object.errors.full_messages.to_sentence
        div(class: "mb-3") do
          plain f.text_field :title,
                            class: "form-control form-control-lg",
                            placeholder: "Name this list...",
                            autofocus: true
        end

        div(class: "mb-3") do
          plain f.text_area :description,
                            class: 'form-control',
                            placeholder: "Add extra details or attach a file..."
        end

        plain f.submit "Create list", class: "btn btn-success btn-sm me-2"
        link_to "Cancel", helpers.lists_path, class: "btn btn-outline-secondary btn-sm"
      end
    end
  end
end
