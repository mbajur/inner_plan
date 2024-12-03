module InnerPlan::Task::Operation
  class UpdatePosition < Trailblazer::Operation
    step Model::Find(InnerPlan::Task, find_by: :id)
    step :assign_position
    step :assign_list
    step :save

    private

    def assign_position(ctx, params:, model:, **)
      model.position = { before: params.dig(:task, :position, :before) }
    end

    def assign_list(ctx, params:, model:, **)
      list_id = params.dig(:task, :list_id)
      return true unless list_id

      model.list = InnerPlan::List.find(list_id)
    end

    def save(ctx, model:, **)
      model.save
    end
  end
end
