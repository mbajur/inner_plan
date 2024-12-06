module InnerPlan::List::Operation
  class Index < Trailblazer::Operation
    step :find_models

    private

    def find_models(ctx, **)
      ctx[:models] = InnerPlan::List.ordered_by_position.root
    end
  end
end
