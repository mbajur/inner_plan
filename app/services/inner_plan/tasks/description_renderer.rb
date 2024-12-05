module InnerPlan::Tasks
  class DescriptionRenderer < Trailblazer::Operation
    include ActionView::Helpers::TextHelper

    step :extract_description
    step :apply_simple_format

    private

    def extract_description(ctx, task:, **)
      ctx[:description] = task.description
    end

    def apply_simple_format(ctx, description:, **)
      ctx[:description] = simple_format(description)
    end
  end
end
