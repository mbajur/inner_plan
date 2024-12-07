module InnerPlan::Groups
  class NewView < InnerPlan::ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::ContentTag
    include Phlex::Rails::Helpers::FormWith

    def initialize(group:)
      @group = group
      @list = group.list
    end

    def template
      form_with model: @group, url: helpers.list_groups_path(@list) do |f|
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
            c.with_breadcrumb do
              link_to @group.list.title,
                      @group.list,
                      class: "text-reset",
                      data: {
                        turbo_frame: :_top
                      }
            end
            c.with_breadcrumb(active: true) { plain " New group " }
          end
          div(class: "row") do
            div(class: "col-6") do
              h1(class: "h2") do
                plain f.text_field :title,
                                  placeholder: "Name this group...",
                                  class: "form-control form-control-lg mt-2"
              end
            end
          end
          render(
            InnerPlan::ProgressBarSeparatorComponent.new(
              completed: @group.tasks.completed.count,
              total: @group.tasks.count
            )
          )
        end

        div(class: "mb-2") do
          plain f.text_area :description,
                            class: 'form-control',
                            placeholder: "Add extra details or attach a file..."
        end

        div(class: "mb-5") do
          plain f.submit "Save changes", class: "btn btn-success btn-sm"
          link_to "Cancel", @list, class: "btn btn-outline-secondary btn-sm"
        end
      end
    end
  end
end
