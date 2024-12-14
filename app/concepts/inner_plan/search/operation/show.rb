module InnerPlan::Search::Operation
  class Show < Trailblazer::Operation
    class ApplySqliteFilter < Trailblazer::Operation
      step :apply_filter

      private

      def apply_filter(ctx, scope:, params:, **)
        ctx[:scope] = if params[:q].present?
          scope.where('title LIKE ?', "%#{params[:q]}%")
        else
          scope.none
        end
      end
    end

    class ApplyPostgresqlFilter < Trailblazer::Operation
      def apply_filter(ctx, scope:, params:, **)
        ctx[:scope] = if params[:q].present?
          scope.where('title ILIKE ?', "%#{params[:q]}%")
        else
          scope.none
        end
      end
    end

    step :resolve_policy_scope
    step :apply_includes
    step :apply_limit
    step Nested(:decide_adapter, auto_wire: [ApplySqliteFilter, ApplyPostgresqlFilter])
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

    def decide_adapter(ctx, **)
      adapter = ActiveRecord::Base.connection_db_config.adapter

      case adapter
      when "sqlite3" then ApplySqliteFilter
      when "postgresql" then ApplyPostgresqlFilter
      else
        raise "Adapter #{adapter} not supported"
      end
    end

    def generate_results(ctx, **)
      ctx[:results] = ctx[:scope]
    end
  end
end
