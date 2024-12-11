module InnerPlan
  class SearchesController < ApplicationController
    layout false

    def show
      @results = InnerPlan::Search::Operation::Show.call(
        current_user: current_inner_plan_user,
        params: params
      )[:results]
    end
  end
end
