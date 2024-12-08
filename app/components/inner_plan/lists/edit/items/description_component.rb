module InnerPlan::Lists::Edit::Items
  class DescriptionComponent < Phlex::HTML
    def initialize(form:)
      @form = form
    end

    def template
      div(class: "mb-2") do
        @form.label :description, class: 'form-label'
        plain @form.text_area :description,
                              class: 'form-control',
                              placeholder: "Add extra details or attach a file..."
      end
    end
  end
end
