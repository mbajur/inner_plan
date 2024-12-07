module InnerPlan::Tasks::Show
  class ItemComponent < Phlex::HTML
    include Phlex::DeferredRender

    def initialize(icon:, title: nil)
      @icon = icon
      @title = title
      @actions = nil
      @body = nil
    end

    def template
      section(class: 'd-grid row-gap-2 mt-3', style: 'grid-template-columns: [icon] 40px [body] minmax(0, 1fr)') do
        div(class: 'opacity-50', style: 'margin-top: -2px') { render(@icon.new(width: 24, height: 24)) }

        hgroup(class: 'd-flex align-items-center') do
          h3(class: 'h6 mb-0') { @title }

          if @actions
            div(class: 'ms-auto') do
              render @actions
            end
          end
        end

        if @body
          div(style: 'grid-column-start: body') { render @body }
        end
      end
    end

    def with_body(&content)
      @body = content
    end

    def with_actions(&content)
      @actions = content
    end
  end
end
