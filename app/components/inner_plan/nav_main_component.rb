module InnerPlan
  class NavMainComponent < Phlex::HTML
    def template
      ul(
        class: "nav nav-tabs card-header-tabs px-5 align-items-center",
        id: "nav-main"
      ) do
        li(class: "nav-item") do
          a(class: "nav-link active", aria_current: "true", href: helpers.root_path) do
            render(
              Phlex::Icons::Tabler::SquareRoundedCheck.new(
                width: 16,
                height: 16,
                class: "me-1"
              )
            )
            plain "Tasks"
          end
        end

        render(InnerPlan::SearchDropdownComponent.new)

        if helpers.inner_plan_user_signed_in?
          li(class: "ms-auto") do
            plain helpers.current_inner_plan_user.inner_plan_to_s
            img(
              class: "rounded-circle ms-2",
              style: "margin-top:-.1 rem",
              src: helpers.current_inner_plan_user.inner_plan_avatar_url,
              width: "20",
              height: "20"
            )
          end
        end
      end
    end
  end
end
