class QueriesController < ApplicationController
  def index
    @queries = Query.all.where("id =?", current_user.id)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
