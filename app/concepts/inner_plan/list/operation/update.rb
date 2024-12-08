module InnerPlan::List::Operation
  class Update < Trailblazer::Operation
    step :assign_default_attributes
    left :validate_model
    step :update_model

    private

    def assign_default_attributes(ctx, model:, params:, **)
      model.title = params[:title]
      model.description = params[:description]
      true
    end

    def validate_model(ctx, model:, **)
      model.validate
    end

    def update_model(ctx, model:, **)
      model.save
    end
  end
end
