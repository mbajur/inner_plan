module InnerPlan
  class ListsController < ApplicationController
    def index
      @lists = InnerPlan::List.all.ordered_by_position
    end

    def update_position
      @list = InnerPlan::List.find(params[:id])
      @list.position = { before: update_positions_params[:position][:before] }
      @list.save!
    end

    private

    def update_positions_params
      params.require(:list).permit(:position, position: :before)
    end
  end
end
