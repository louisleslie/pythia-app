class QueriesController < ApplicationController
  def index
    @authorized = false
    csv_file = CsvFile.find(params[:csv_file_id])
    return unless csv_file.user.id == current_user.id

    @authorized = true
    @queries = csv_file.queries
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
