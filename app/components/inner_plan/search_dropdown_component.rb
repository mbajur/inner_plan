module InnerPlan
  class SearchDropdownComponent < Phlex::HTML
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::Tag

    def template
      li(class: "nav-item dropdown", data_controller: "search-dropdown") do
        a(
          class: "nav-link text-reset",
          data_bs_toggle: "dropdown",
          href: "#",
          role: "button",
          data_search_dropdown_target: "toggle"
        ) do
          render(
            Phlex::Icons::Tabler::Search.new(
              width: 16,
              height: 16,
              class: "me-1"
            )
          )
          plain " Find "
        end

        div(class: "dropdown-menu", style: "width:600px") do
          form_with url: helpers.search_path,
                    class: "px-3 py-2",
                    method: :get,
                    data: {
                      turbo_frame: "search-results",
                      search_dropdown_target: :form
                    } do |f|
            input(
              type: "search",
              class: "form-control",
              name: "q",
              placeholder: "Search for...",
              autocomplete: "off",
              data_search_dropdown_target: "input",
              incremental: "incremental",
              data_action: " search->search-dropdown#submit"
            )
          end
          tag('turbo-frame', id: "search-results")
        end
      end
    end
  end
end
