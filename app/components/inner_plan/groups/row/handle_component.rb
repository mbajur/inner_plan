module InnerPlan::Groups::Row
  class HandleComponent < Phlex::HTML
    include Phlex::Rails::Helpers::LinkTo

    def initialize(list)
      @list = list
    end

    def template
      div(class: "dropstart me-2", style: "margin-top:-0.15rem") {
        a(class: "align-top text-body-tertiary group-handle cm", data: { bs_toggle: :dropdown }) {
          render(Phlex::Icons::Tabler::GripVertical.new(width: 20, height: 20))
        }

        ul(class: 'dropdown-menu') {
          li {
            link_to(helpers.edit_group_path(list), class: "dropdown-item d-flex gap-2 align-items-center") {
              render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18, class: 'text-secondary'))
              span { 'Edit group' }
            }
          }
        }
      }
    end

    private

    attr_reader :list
  end
end
