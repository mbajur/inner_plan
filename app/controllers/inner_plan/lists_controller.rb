module InnerPlan
  class ListsController < ApplicationController
    def index
      @lists = InnerPlan::List::Operation::Index.call[:models]
      render InnerPlan::Lists::IndexView.new(lists: @lists)
    end

    def show
      @list = InnerPlan::List.root.find(params[:id])
      render InnerPlan::Lists::ShowView.new(list: @list)
    end

    def new
      @list = InnerPlan::List.new
      render InnerPlan::Lists::NewView.new(list: @list)
    end

    def create
      @list = InnerPlan::List.new(list_params)
      @list.user = current_inner_plan_user

      if @list.save
        redirect_to lists_path
      else
        render InnerPlan::Lists::NewView.new(list: @list), status: :unprocessable_entity
      end
    end

    def edit
      @list = InnerPlan::List.root.find(params[:id])
      render InnerPlan::Lists::EditView.new(list: @list)
    end

    def update
      @list = InnerPlan::List.root.find(params[:id])
      if @list.update(list_params)
        redirect_to list_path(@list)
      else
        render InnerPlan::Lists::EditView.new(list: @list)
      end
    end

    def update_position
      @list = InnerPlan::List.root.find(params[:id])
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
