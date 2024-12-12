module InnerPlan
  module Searches
    class ResultComponent < Phlex::HTML
      include Phlex::Rails::Helpers::LinkTo
      include Phlex::Rails::Helpers::Excerpt

      def initialize(result:)
        @result = result
      end

      def template
        div(class: "d-flex p-3") do
          img(
            src: @result.user.inner_plan_avatar_url,
            width: 50,
            height: 50,
            class: "rounded-circle",
            title: @result.user.inner_plan_to_s
          )
          div(class: "ps-3") do
            div(class: "text-body-tertiary") do
              plain breadcrumbs
              time(datetime: "2024-07-24T12:59:55Z") do
                @result.created_at.strftime("%a, %b %e, %Y")
              end
            end

            h4(class: "h6 my-1") do
              link_to(@result.title, @result, target: :_top)
            end

            description
          end
        end
      end

      private

      def breadcrumbs
        parts = []

        parts << @result.list.title
        parts.unshift(@result.list.list.title) if @result.list.sub?

        plain "#{parts.join(' – ')} · "
      end

      def description
        div do
          excerpt(@result.description, '')
        end
      end
    end
  end
end
