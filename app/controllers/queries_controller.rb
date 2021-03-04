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
    @results = fetch_query_results(@query)
    @sql_query = generate_query(@query)
  end

  def new
    @query = Query.new
    @query.filters.build
    @order_data_types = {}
    Order.columns_hash.map { |k, v| @order_data_types[k] = v.sql_type_metadata.type }
  end

  def create
    @query = Query.new(query_params)
    @csv_file = CsvFile.find(params[:csv_file_id])
    @query.csv_file = @csv_file
    if @query.save
      redirect_to csv_file_queries_path(@csv_file)
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

  private

  def set_query
    @query = Query.find(params[:id])
  end

  def query_params
    params.require(:query).permit(:fields, :query_name, filters_attributes: [:verb, :column_name, :comparison_operator, :value])
  end

  def fetch_query_results(query)
    filtrs = []
    query.filters.each do |filt|
      
    end
  end

  def generate_query(query)
    fields = query.fields
    base_query = "SELECT #{fields} FROM orders"

    # converted_query_filters = []
    # query.filters.each do |filter|
    #   verb = filters.verb
    #   operator = filters.comparison_operator
    #   column = filters.column_name
    #   value = filters.value
    #   converted_query_filters << ".#{verb}"
    # end
    return base_query
  end

end
