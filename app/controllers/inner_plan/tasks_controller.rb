module InnerPlan
  class TasksController < ApplicationController
    def index
      @lists = InnerPlan::List.root
    end

    def new
      @task = InnerPlan::Task.new
      @list = InnerPlan::List.find(params[:list_id])
    end

    def show
      @task = InnerPlan::Task.find(params[:id])
    end

    def create
      @list = InnerPlan::List.find(params[:list_id])
      @task = @list.tasks.new(task_params)
      @task.user = current_user
      @task.position = :last

      if @task.save
        @new_task = InnerPlan::Task.new
      else
        render :create_failure, status: :unprocessable_entity
      end
    end

    def edit
      @task = InnerPlan::Task.find(params[:id])
    end

    def update
      update_params = task_params
      update_params[:assigned_user_ids] = update_params[:assigned_user_ids].split(',')
      @task = InnerPlan::Task.find(params[:id])

      if @task.update(update_params)
        redirect_to task_path(@task)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def update_position
      @task = InnerPlan::Task.find(params[:id])
      @task.position = { before: update_positions_params[:position][:before] }
      @task.list = InnerPlan::List.find(update_positions_params[:list_id]) if update_positions_params[:list_id]
      @task.save!
    end

    def complete
      @task = InnerPlan::Task.find(params[:id])
      @task.complete!

      respond_to do |format|
        format.turbo_stream
      end
    end

    def reopen
      @task = InnerPlan::Task.find(params[:id])
      @task.reopen!

      respond_to do |format|
        format.turbo_stream { render :complete }
      end
    end

    private

    def task_params
      params.require(:task).permit(:title, :description, :due_on, :assigned_user_ids)
    end

    def update_positions_params
      params.require(:task).permit(:list_id, :position, position: :before)
    end
  end
end
