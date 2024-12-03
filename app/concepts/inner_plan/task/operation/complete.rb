module InnerPlan::Task::Operation
  class Complete < Trailblazer::Operation
    step Model::Find(InnerPlan::Task, find_by: :id)
    step :mark_as_complete

    private

    def mark_as_complete(ctx, model:, **)
      model.complete!
    end
  end
end
