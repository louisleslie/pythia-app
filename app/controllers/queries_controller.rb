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
    @sql_query = generate_query(@query)
    @results = Order.connection.select_all(@sql_query)
  end

  def new
    @query = Query.new
    @query.filters.build
    @order_data_types = {}
    Order.columns_hash.map { |k, v| @order_data_types[k] = "#{k}-#{v.sql_type_metadata.type}" }
  end

  def create
    @query = Query.new(query_params)
    @query.fields = params[:query][:fields].to_s
    @order_data_types = {}
    Order.columns_hash.map { |k, v| @order_data_types[k] = "#{k}-#{v.sql_type_metadata.type}" }
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

  def generate_query(query)
    # TODO make this line DRY
    clean_up_fields = query.fields.gsub(/"/, "").gsub(/\[/, "").gsub(/\]/, "")
    # fields adds an empty first element so this line removes it
    formatted_fields = clean_up_fields.split(",")[1, query.fields.length].join(", ")
    base_query = "SELECT #{formatted_fields} FROM orders"
    converted_query_filters = []

    query.filters.each do |filter|
      verb = filter.verb.upcase
      operator = convert_operator(filter.comparison_operator)
      column = filter.column_name.split("-")[0]
      value = filter.value
      converted_query_filters << " #{verb} #{column} #{operator} #{value}"
    end

    # currently this only handles WHERE verbs I havent added the logic for group by yet
    first_filter = converted_query_filters.pop
    # convert subsequent WHEREs to AND
    subsequent_filters = converted_query_filters.join.gsub("WHERE", "AND")

    return base_query + first_filter + subsequent_filters
  end

  def convert_operator(text_operator)
    case text_operator
    when "Equals" then return "="
    when "Greater Than" then return ">"
    end
  end

end
