class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user
  before_action :logged_in?

  # GET /tasks
  # GET /tasks.json
  def index
    @q = current_user.tasks.includes(:user).ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(2)


  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    if current_user.id != @task.user_id
    flash[:notice] = "Not Allowed!"
    redirect_to tasks_path(session[:task_user])
    return
  end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    if current_user.id != @task.user_id
    flash[:notice] = "Not Allowed!"
    redirect_to tasks_path(session[:task_user])
    return
  end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def authenticate_user
      if @current_user == nil
        flash[:notice] = t('notice.login_needed')
        redirect_to new_session_path
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :id, :deadline, :status, :priority, :user_id)
    end
end
