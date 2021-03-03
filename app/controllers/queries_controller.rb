class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :edit, :update, :destroy]
  def index
    @authorized = false
    csv_file = CsvFile.find(params[:csv_file_id])
    return unless csv_file.user.id == current_user.id

    @authorized = true
    @queries = csv_file.queries
  end

  def show
    @query = Query.new
  end

  def new
    @query = Query.new
  end

  def create
    @query = Query.new(query_params)
    @csv_file = CsvFile.find(params[:csv_file_id])
    @query.csv_file =  @csv_file
    if @query.save
      redirect_to csv_file_path(@csv_file)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def edit
    @csv_file = @query.csv_file
  end

  def update
    @csv_file = @query.csv_file
    @query.update(query_params)
    redirect_to csv_file_path(@csv_file)
  end

  def destroy
    @csv_file = @query.csv_file
    @query.destroy
    redirect_to csv_files_path(@csv_file)
  end

  def set_query
    @query = Query.find(params[:id])
  end

  def query_params
    params.require(:query).permit(:fields, :query_name)
  end
end
