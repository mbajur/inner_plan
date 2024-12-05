module InnerPlan::Task::Operation
  class Update < Trailblazer::Operation
    step Model::Find(InnerPlan::Task, find_by: :id)
    step :assign_attributes
    left :validate_model
    step :update_model

    private

    def assign_attributes(ctx, model:, params:, **)
      model.title = params[:title]
      model.description = params[:description]
      model.due_on = params[:due_on]
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
