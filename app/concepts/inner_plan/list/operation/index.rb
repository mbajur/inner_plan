module InnerPlan::List::Operation
  class Index < Trailblazer::Operation
    step :resolve_policy_scope
    step :find_models

    private

    def resolve_policy_scope(ctx, current_user:, **)
      ctx[:scope] = InnerPlan::ListPolicy::Scope.new(current_user, InnerPlan::List).resolve
    end

    def find_models(ctx, **)
      ctx[:models] = ctx[:scope].ordered_by_position.root
    end
  end
end
