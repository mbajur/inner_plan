module InnerPlan
  class BreadcrumbsComponent < Phlex::HTML
    include Phlex::DeferredRender
    include Phlex::Rails::Helpers::LinkTo

    def initialize
      @breadcrumbs = []
    end

    def template
      nav(class: 'mb-1', style: "--bs-breadcrumb-divider: '›';") {
        ol(class: "breadcrumb mb-0") {
          @breadcrumbs.each do |breadcrumb|
            li(class: 'breadcrumb-item text-body-tertiary') {
              breadcrumb[:content].call
            }
          end
        }
      }
    end

    def with_breadcrumb(active: false, &content)
      @breadcrumbs << { active: active, content: content }
    end
  end
end
