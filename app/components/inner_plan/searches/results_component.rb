module InnerPlan
  module Searches
    class ResultsComponent < Phlex::HTML
      include Phlex::Rails::Helpers::LinkTo

      def initialize(results:)
        @results = results
      end

      def template
        @results.each do |result|
          render(InnerPlan::Searches::ResultComponent.new(result: result))
        end
      end
    end
  end
end
