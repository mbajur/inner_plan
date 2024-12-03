module InnerPlan::Task::Operation
  class Update < Trailblazer::Operation
    # step :find_list
    # step :initialize_model
    # step :assign_list
    # step :assign_user
    # step :assign_position
    # left :validate_model
    # step :save_model
    step Model::Find(InnerPlan::Task, find_by: :id)
    step :assign_attributes
    left :validate_model
    step :update_model

    private

    def assign_attributes(ctx, model:, params:, **)
      model.assign_attributes(params)
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
