class TasksController < ApplicationController
  
  def index
    if logged_in?
      @task = current_user.tasks.build
      @pagy, @tasks = pagy(Task.all.order(id: :asc), items: 3)
    end
  end
  
  def show
    set_task
    #@task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
      
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new 
    end
  end
  
  
  def edit
    set_task
    #@task = Task.find(params[:id])
  end

  def update
    set_task
    #@task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_task
    #@task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  

  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
end
