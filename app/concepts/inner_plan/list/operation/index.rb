module InnerPlan::List::Operation
  class Index < Trailblazer::Operation
    step :find_models

    private

    def assign_attributes(ctx, **)
      ctx[:models] = InnerPlan::List.root
    end
  end
end
