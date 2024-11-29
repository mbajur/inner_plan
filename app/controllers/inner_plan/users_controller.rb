module InnerPlan
  class UsersController < ApplicationController
    def index
      scope = InnerPlan.configuration.user_class_name.constantize.all
      scope = scope.where(id: params[:combobox_values].split(',')) if params[:combobox_values].present?

      render turbo_stream: helpers.async_combobox_options(scope)
    end

    def combobox_chips
      @users = InnerPlan.configuration.user_class_name.constantize.where(id: params[:combobox_values].split(','))
      render turbo_stream: helpers.combobox_selection_chips_for(@users)
    end
  end
end
