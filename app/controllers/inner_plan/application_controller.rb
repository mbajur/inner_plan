module InnerPlan
  class ApplicationController < ActionController::Base
    include Pundit::Authorization

    helper_method :current_inner_plan_user

    private

    def pundit_user
      current_inner_plan_user
    end

    def current_inner_plan_user
      @current_inner_plan_user ||=
        public_send(InnerPlan.configuration.current_user_method)
    end

    def inner_plan_user_signed_in?
      current_inner_plan_user.present?
    end
  end
end
