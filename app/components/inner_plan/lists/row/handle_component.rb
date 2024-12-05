module InnerPlan::Lists::Row
  class HandleComponent < Phlex::HTML
    include Phlex::Rails::Helpers::LinkTo

    def initialize(list)
      @list = list
    end

    def template
      div(class: "dropstart", style: "padding-top:1.5rem") {
        a(class: "align-top me-2 text-body-tertiary list-handle cm", data: { bs_toggle: :dropdown }) {
          render(Phlex::Icons::Tabler::GripVertical.new(width: 20, height: 20))
        }

        ul(class: "dropdown-menu") {
          li {
            link_to(helpers.edit_list_path(list), class: "dropdown-item d-flex gap-2 align-items-center") {
              render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18, class: 'text-secondary'))
              span { 'Edit list' }
            }
          }

          li {
            link_to(helpers.new_list_group_path(list), class: "dropdown-item d-flex gap-2 align-items-center") {
              render(Phlex::Icons::Tabler::Apps.new(width: 18, height: 18, class: 'text-secondary'))
              span { 'Add group' }
            }
          }
        }
      }
    end

    private

    attr_reader :list
  end
end
