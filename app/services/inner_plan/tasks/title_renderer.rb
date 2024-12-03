module InnerPlan::Tasks
  class TitleRenderer < Trailblazer::Operation
    include ActionView::Helpers::SanitizeHelper

    step :extract_title
    step :sanitize_title

    private

    def extract_title(ctx, task:, **)
      ctx[:title] = task.title
    end

    def sanitize_title(ctx, title:, **)
      ctx[:title] = sanitize(title)
    end
  end
end
