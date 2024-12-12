module InnerPlan::Search::Operation
  class Show < Trailblazer::Operation
    step :resolve_policy_scope
    step :apply_includes
    step :apply_limit
    step :apply_filter
    step :generate_results

    private

    def resolve_policy_scope(ctx, current_user:, **)
      ctx[:scope] = InnerPlan::TaskPolicy::Scope.new(current_user, InnerPlan::Task).resolve
    end

    def apply_includes(ctx, scope:, **)
      ctx[:scope] = scope.includes(:user)
    end

    def apply_limit(ctx, scope:, **)
      ctx[:scope] = scope.limit(5)
    end

    def apply_filter(ctx, scope:, params:, **)
      ctx[:scope] = if params[:q].present?
        scope.where('title LIKE ?', "%#{params[:q]}%")
      else
        scope.none
      end
    end

    def generate_results(ctx, **)
      ctx[:results] = ctx[:scope]
    end
  end
end
