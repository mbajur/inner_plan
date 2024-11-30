module InnerPlan
  class GroupsController < ApplicationController
    def show
      @group = InnerPlan::Group.find(params[:id])
    end

    def edit
      @group = InnerPlan::Group.find(params[:id])
    end

    def update
      @group = InnerPlan::Group.find(params[:id])

      if @group.update(group_params)
        redirect_to group_path(@group)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def new
      @list = InnerPlan::List.find(params[:list_id])
      @group = @list.groups.new(params[:id])
    end

    def create
      @group = InnerPlan::Group.new(group_params)
      @group.list = InnerPlan::List.find(params[:list_id])
      @group.user = current_user
      @group.position = :last

      if @group.save
        redirect_to @group.list
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update_position
      @group = InnerPlan::Group.find(params[:id])
      @group.position = { before: update_positions_params[:position][:before] }
      @group.list = InnerPlan::List.find(update_positions_params[:list_id]) if update_positions_params[:list_id]
      @group.save!
    end

    private

    def group_params
      params.require(:group).permit(:title, :description)
    end

    def update_positions_params
      params.require(:group).permit(:list_id, :position, position: :before)
    end
  end
end
