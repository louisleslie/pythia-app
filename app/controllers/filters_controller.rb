class FiltersController < ApplicationController
  before_action :set_filter, only: [:edit, :update, :destroy]

  def edit
    @query = @filter.query
  end

  def new
    @filter = Filter.new
  end

  def create
    @filter = Filter.new(filter_params)
    @query = Query.new(params[:query_id])
    @filter.query = @query
    if @filter.save
      puts "filters saved! "
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def update
    @query = @filter.query
    filter.update(filter_params)
  end


  def destroy
    @query = @filter.query
    @filter.destroy
  end

  def set_filter
    @filter = Filter.find(params[:id])
  end

  def filter_params
    params.require(:filter).permit(:comparison_operator, :column_name, :value, :verb)
  end
end
