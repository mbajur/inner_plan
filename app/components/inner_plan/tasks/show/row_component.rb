module InnerPlan::Tasks::Show
  class RowComponent < Phlex::HTML
    def initialize
      @columns = []
    end

    def template(&content)
      div(class: "row") {
        render content
      }
    end

    def with_column(span: 6, &content)
      div(class: "col-#{span}") {
        render content
      }
    end
  end
end
