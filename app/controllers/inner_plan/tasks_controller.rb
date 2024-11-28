module InnerPlan
  class TasksController < ApplicationController
    def index
      @lists = InnerPlan::List.root
    end

    def new
      @task = InnerPlan::Task.new
      @group = InnerPlan::Group.find(params[:group_id])
    end

    def show
      @task = InnerPlan::Task.find(params[:id])
    end

    def create
      @group = InnerPlan::Group.find(params[:group_id])
      @task = @group.tasks.new(task_params)
      @task.position = :last

      if @task.save
        @new_task = InnerPlan::Task.new
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @task = InnerPlan::Task.find(params[:id])
    end

    def update
      @task = InnerPlan::Task.find(params[:id])

      if @task.update(task_params)
        redirect_to task_path(@task)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def update_position
      @task = InnerPlan::Task.find(params[:id])
      @task.position = { before: update_positions_params[:position][:before] }
      @task.group = InnerPlan::Group.find(update_positions_params[:group_id]) if update_positions_params[:group_id]
      @task.save!
    end

    def complete
      @task = InnerPlan::Task.find(params[:id])
      @task.complete!

      @ongoing_tasks = InnerPlan::Task.ongoing
      @completed_tasks = InnerPlan::Task.completed.limit(3)
      @completed_tasks_count = InnerPlan::Task.completed.count

      respond_to do |format|
        format.turbo_stream
      end
    end

    def reopen
      @task = InnerPlan::Task.find(params[:id])
      @task.reopen!

      @ongoing_tasks = InnerPlan::Task.ongoing
      @completed_tasks = InnerPlan::Task.completed.limit(3)
      @completed_tasks_count = InnerPlan::Task.completed.count

      respond_to do |format|
        format.turbo_stream { render :complete }
      end
    end

    private

    def task_params
      params.require(:task).permit(:title, :description, :due_on)
    end

    def update_positions_params
      params.require(:task).permit(:group_id, :position, position: :before)
    end
  end
end
