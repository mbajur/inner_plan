module InnerPlan::Tasks::Form
  class ItemComponent < Phlex::HTML
    def initialize(icon:, title: nil)
      @icon = icon
      @title = title
    end

    def template(&content)
      div(class: "d-flex mb-4") do
        div(class: "me-3 text-body-tertiary", style: "margin-top:-.2 rem") do
          render(@icon.new(width: 24, height: 24))
        end

        div(class: "pe-4 w-100") do
          h6 { @title }
          render content
        end
      end
    end
  end
end
