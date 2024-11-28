module InnerPlan
  class ListsController < ApplicationController
    def index
      @lists = InnerPlan::List.all.ordered_by_position
    end

    def show
      @list = InnerPlan::List.find(params[:id])
    end

    def new
      @list = InnerPlan::List.new
    end

    def create
      @list = InnerPlan::List.new(list_params)
      @list.groups.build(default: true, title: 'Default')

      if @list.save
        redirect_to lists_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @list = InnerPlan::List.find(params[:id])
    end

    def update
      @list = InnerPlan::List.find(params[:id])
      if @list.update(list_params)
        redirect_to list_path(@list)
      else
        render :edit
      end
    end

    def update_position
      @list = InnerPlan::List.find(params[:id])
      @list.position = { before: update_positions_params[:position][:before] }
      @list.save!
    end

    private

    def list_params
      params.require(:list).permit(:title, :description)
    end

    def update_positions_params
      params.require(:list).permit(:position, position: :before)
    end
  end
end
