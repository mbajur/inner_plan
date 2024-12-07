module InnerPlan::Tasks
  class CompletedTogglerComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ButtonTo

    def initialize(task, context: nil, size: 24)
      @task = task
      @context = context
      @size = size
    end

    def template
      if task.ongoing?
        button_to(helpers.complete_task_path(task, context: context), method: :post, class: 'btn p-0 opacity-50', style: 'height:24px;display:block;margin-top:-1px', form: { style: 'height:24px;display:block;' }) {
          render(Phlex::Icons::Tabler::SquareRounded.new(width: size, height: size))
        }
      else
        button_to(helpers.reopen_task_path(task, context: context), method: :post, class: 'btn p-0 text-success opacity-75') {
          render(Phlex::Icons::Tabler::SquareRoundedCheck.new(width: size, height: size))
        }
      end
    end

    private

    attr_reader :task, :context, :size
  end
end
