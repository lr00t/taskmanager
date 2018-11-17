class TasksController < ApplicationController
  before_action :authorize

  before_action do
    @scope = current_user.admin? ? Task.ordered : current_user.tasks
  end

  def index
    @tasks = @scope
  end

  def new
    @task = Task.new
  end

  def create
    @task = @scope.new(allowed_params)
    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def show
    @task = @scope.find(params[:id])
  end

  def edit
    @task = @scope.find(params[:id])
  end

  def update
    @task = @scope.find(params[:id])
    if @task.update_attributes(allowed_params)
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task = @scope.find(params[:id])
    @task.destroy
    redirect_to url_for(action: :index)
  end

  def start
    @task = @scope.find(params[:id])
    redirect_to root_path if @task.start!
  end

  def finish
    @task = @scope.find(params[:id])
    redirect_to root_path if @task.finish!
  end

  private

  def allowed_params
    params.require(:task).permit(:name, :description, :file, :file_cahce, :user_id)
  end
end
