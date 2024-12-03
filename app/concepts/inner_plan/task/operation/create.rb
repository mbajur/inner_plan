module InnerPlan::Task::Operation
  class Create < Trailblazer::Operation
    step :find_list
    step :initialize_model
    step :assign_list
    step :assign_user
    step :assign_position
    left :validate_model
    step :save_model

    private

    def find_list(ctx, list_id:, **)
      ctx[:list] = InnerPlan::List.find(list_id)
    end

    def initialize_model(ctx, params:, **)
      ctx[:model] = InnerPlan::Task.new(params)
    end

    def assign_list(ctx, list:, model:, **)
      model.list = list
    end

    def assign_position(ctx, model:, **)
      model.position = :last
    end

    def assign_user(ctx, current_user:, model:, **)
      model.user = current_user
    end

    def validate_model(ctx, model:, **)
      model.validate
    end

    def save_model(_ctx, model:, **)
      model.save
    end
  end
end
