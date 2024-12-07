module InnerPlan::Tasks::Show::Items
  class CreatedByComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ClassNames

    def initialize(task:)
      @task = task
    end

    def template
      render(
        InnerPlan::Tasks::Show::ItemComponent.new(icon: Phlex::Icons::Tabler::CirclePlus, title: 'Created By') do |c|
          c.with_body do
            div(class: "text-body-tertiary") do
              render(InnerPlan::UserWithAvatarComponent.new(@task.user))
              plain " on "
              plain @task.created_at.strftime("%a, %b %e, %Y")
            end
          end
        end
      )
    end

    private

    def description
      InnerPlan::Tasks::DescriptionRenderer.call(task: @task)[:description]
    end
  end
end
