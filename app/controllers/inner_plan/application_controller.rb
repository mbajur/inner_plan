module InnerPlan
  class ApplicationController < ActionController::Base
    include Pundit::Authorization

    helper_method :current_inner_plan_user

    private

    def current_inner_plan_user
      @current_inner_plan_user ||=
        public_send(InnerPlan.configuration.current_user_method)
    end
  end
end
