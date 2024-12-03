module InnerPlan::Task::Operation
  class Reopen < Trailblazer::Operation
    step Model::Find(InnerPlan::Task, find_by: :id)
    step :reopen

    private

    def reopen(ctx, model:, **)
      model.reopen!
    end
  end
end
