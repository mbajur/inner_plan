module InnerPlan
  class GroupsController < ApplicationController
    def show
      @group = InnerPlan::List.sub.find(params[:id])
    end

    def edit
      @group = InnerPlan::List.sub.find(params[:id])
    end

    def update
      @group = InnerPlan::List.sub.find(params[:id])

      if @group.update(group_params)
        redirect_to group_path(@group)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def new
      @list = InnerPlan::List.root.find(params[:list_id])
      @group = @list.lists.new(params[:id])
    end

    def create
      @group = InnerPlan::List.new(group_params)
      @group.list = InnerPlan::List.root.find(params[:list_id])
      @group.user = current_user
      @group.position = :last

      if @group.save
        redirect_to @group.list
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update_position
      @group = InnerPlan::List.sub.find(params[:id])
      @group.position = { before: update_positions_params[:position][:before] }
      @group.list = InnerPlan::List.root.find(update_positions_params[:list_id]) if update_positions_params[:list_id]
      @group.save!
    end

    private

    def group_params
      params.require(:list).permit(:title, :description)
    end

    def update_positions_params
      params.require(:list).permit(:list_id, :position, position: :before)
    end
  end
end
