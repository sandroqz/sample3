class TasksController < ApplicationController
  respond_to :html, :json, :js

  # GET /tasks
  # GET /tasks.json
  def index
    @task = Task.new params[:task]
    @tasks = Task.order("title")
    %w{title owner tags description}.each do |field|
      val = @task.send(field.to_sym)
      @tasks = @tasks.where("#{field} like ?", val + "%") if val && val != ""
    end
    respond_with @tasks
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    respond_with @task
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.save
    @tasks = Task.all
    respond_with @task
  end

  def update
    @task = Task.find(params[:id])
    @task.completed_at = Time.now
    @task.save
    respond_with @task
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_with @task
  end
end
