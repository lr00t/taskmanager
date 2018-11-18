class TasksController < ApplicationController
  before_action :authorize

  before_action do
    @scope = current_user.admin? ? Task.ordered : current_user.tasks
  end
  before_action :load_resource!, except: [:index, :new, :create]

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

  def show; end

  def edit; end

  def update
    if @task.update_attributes(allowed_params)
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to url_for(action: :index)
  end

  def start
    redirect_to root_path if @task.start!
  end

  def finish
    redirect_to root_path if @task.finish!
  end

  private

  def load_resource!
    @task = @scope.find(params[:id])
  end

  def allowed_params
    params.require(:task).permit(:name, :description, :file, :file_cahce, :user_id)
  end
end
