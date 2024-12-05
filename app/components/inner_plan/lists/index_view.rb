module InnerPlan::Lists
  class IndexView < ApplicationView
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes

    def initialize(lists:)
      @lists = lists
    end

    def template
      header(class: %(mb-4)) {
        div(class: %(row)) {
          div(class: %(col-6)) {
            h1(class: %(h2)) {
              plain %(Tasks)
              small(class: %(fs-6 text-body-tertiary ms-2)) {
                plain InnerPlan::Task.completed.count
                plain %(/)
                plain InnerPlan::Task.all.count
              }
            }
          }
          div(class: %(col-6 text-end)) {
            link_to('+ New list', helpers.new_list_path,
                                  class: 'btn btn-success',
                                  data: { turbo_frame: dom_id(InnerPlan::List.new, :form) })
          }
        }

        render(
          InnerPlan::ProgressBarSeparatorComponent.new(
            completed: InnerPlan::Task.completed.count,
            total: InnerPlan::Task.all.count
          )
        )
      }

      if @lists.none?
        div(class: %(text-center mt-5 pt-5)) {
          render(partial: 'inner_plan/shared/blankslate', formats: [:svg])

          h3(class: %(mt-5)) { %(Nothing here) }
          p(class: %(text-secondary)) {
            plain %( Looks like there are no tasks here yet. )
          }
        }
      end

      div(data_controller: %(lists)) {
        @lists.each do |list|
          render(InnerPlan::Lists::RowComponent.new(list, context: :lists_index))
        end
      }
    end
  end
end
