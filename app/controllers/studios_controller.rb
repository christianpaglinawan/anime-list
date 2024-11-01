class StudiosController < ApplicationController
  def index
    @studios = Studio.order("name ASC").page(params[:page]).per(10)
  end

  def show
    @studios = Studio.find(params[:id])
  end
end
