class TasksController < ApplicationController
  before_action :set_user_id
  
  def index
    @tasks = Task.all
  end
end
