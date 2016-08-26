class Api::TodosController < ApplicationController
  def index
    @todos = Todo.all

    render json: @todos
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save!
      render json: @todo
    else
      return
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      render json: @todo
    else
      return
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    render json: @todo
  end

  def todo_params
    params.require(:todo).permit(:title, :body, :done)
  end
end
