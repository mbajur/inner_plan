module InnerPlan::List::Operation
  class Create < Trailblazer::Operation
    step :initialize_model
    step :assign_user
    step :assign_position
    left :validate_model
    step :save_model

    private

    def initialize_model(ctx, params:, **)
      model = InnerPlan::List.new
      model.title = params[:title]
      model.description = params[:description]

      ctx[:model] = model
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
