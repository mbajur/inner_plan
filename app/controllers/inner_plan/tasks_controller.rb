module InnerPlan
  class TasksController < ApplicationController
    def index
      @lists = InnerPlan::List::Operation::Index.call
    end

    def new
      @task = InnerPlan::Task.new
      @list = InnerPlan::List.find(params[:list_id])
    end

    def show
      @task = InnerPlan::Task.find(params[:id])
      render InnerPlan::Tasks::ShowView.new(task: @task)
    end

    def create
      result = InnerPlan::Task::Operation::Create.call(
        list_id: params[:list_id],
        current_user: current_inner_plan_user,
        params: params.fetch(:task, {})
      )
      @task, @list = result[:model], result[:list]

      if result.success?
        @new_task = InnerPlan::Task.new
      else
        render :create_failure, status: :unprocessable_entity
      end
    end

    def edit
      @task = InnerPlan::Task.find(params[:id])
      render InnerPlan::Tasks::EditView.new(task: @task, focus: params[:focus])
    end

    def update
      result = InnerPlan::Task::Operation::Update.call(
        params: params.fetch(:task, {}).merge(id: params[:id])
      )
      @task = result[:model]

      if result.success?
        redirect_to task_path(@task)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def update_position
      result = InnerPlan::Task::Operation::UpdatePosition.call(params: params)
      @task = result[:model]
    end

    def complete
      result = InnerPlan::Task::Operation::Complete.call(params: params)
      @task = result[:model]

      respond_to do |format|
        format.turbo_stream
      end
    end

    def reopen
      result = InnerPlan::Task::Operation::Reopen.call(params: params)
      @task = result[:model]

      respond_to do |format|
        format.turbo_stream { render :complete }
      end
    end
  end
end
