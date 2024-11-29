module InnerPlan::Lists
  class ShowMenuComponent < Phlex::HTML
    include Phlex::Rails::Helpers::LinkTo

    def initialize(list)
      @list = list
    end

    def template
      div(class: "dropdown") {
        button(class: "btn btn-link text-reset p-0 opacity-50", data_bs_toggle: "dropdown") {
          render(Phlex::Icons::Tabler::DotsCircleHorizontal.new(width: 35, height: 35))
        }

        ul(class: "dropdown-menu dropdown-menu-end") {
          li {
            link_to(helpers.edit_list_path(list), class: 'dropdown-item d-flex align-items-center gap-2', data: { turbo_frame: :_top }) {
              render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18, class: 'text-secondary'))
              span { "Edit list" }
            }
          }

          li {
            link_to(helpers.new_list_group_path(list), class: 'dropdown-item d-flex align-items-center gap-2', data: { turbo_frame: :_top }) {
              render(Phlex::Icons::Tabler::ListDetails.new(width: 18, height: 18, class: 'text-secondary'))
              span { "Add Group" }
            }
          }
        }
      }
    end

    private

    attr_reader :list
  end
end
