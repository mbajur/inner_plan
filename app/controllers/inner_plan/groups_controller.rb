module InnerPlan
  class GroupsController < ApplicationController
    def update_position
      @group = InnerPlan::Group.find(params[:id])
      @group.position = { before: update_positions_params[:position][:before] }
      @group.list = InnerPlan::List.find(update_positions_params[:list_id]) if update_positions_params[:list_id]
      @group.save!
    end

    private

    def update_positions_params
      params.require(:group).permit(:list_id, :position, position: :before)
    end
  end
end
