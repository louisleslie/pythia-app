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
    # TODO: make this line DRY
    clean_up_fields = query.fields.gsub(/"/, "").gsub(/\[/, "").gsub(/\]/, "")
    # fields adds an empty first element so this line removes it
    formatted_fields = clean_up_fields.split(",")[1, query.fields.length].join(", ")
    formatted_fields = "*" if formatted_fields.split(",").count == 61 # TODO: find a more dynamic way to do this
    base_query = "SELECT #{formatted_fields} FROM orders"
    converted_query_filters = []

    query.filters.each do |filter|
      verb = filter.verb.upcase
      column = filter.column_name.split("-")[0]
      operator = convert_operator(filter.comparison_operator, column)
      value = filter.value
      converted_query_filters << " #{verb} #{column} #{operator} #{value}"
    end

    # currently this only handles WHERE verbs I havent added the logic for group by yet
    first_filter = converted_query_filters.pop
    # convert subsequent WHEREs to AND
    subsequent_filters = converted_query_filters.join.gsub("WHERE", "AND")

    return base_query + first_filter + subsequent_filters
  end

  def convert_operator(text_operator, column)
    comparison_conversion = {
      "Equals" => "=",
      "Does Not Equal" => "<>", # not tested
      "Greater Than" => ">",
      "Less Than" => "<",
      "Greater Than or Equal To" => ">=", # not tested
      "Less Than or Equal To" => "<=", # not tested
      "Is Empty" => "IS NULL OR #{column} = ''", # not tested
      "Is Not Empty" => "<> ''", # not tested
      "Is" => "= 'yes' OR #{column} = 1 OR #{column} = 'true'", # TODO: not sure if true and no need to be in quotation marks # not tested
      "Is Not" => "= 'no' OR #{column} = 0 OR #{column} = 'false'", # TODO: same as above # not tested
      "Contains" => "ILIKE", # TODO: this should match substrings (currently only matches exact values) # not tested
      "Does Not Contain" => "NOT ILIKE", # TODO: this should match substrings (currently only matches exact values) # not tested
      "Starts With" => "ILIKE", # TODO: should match substrings only at the start of the field # # not tested
      "Ends With" => "ILIKE", # TODO: should match substrings only at the end of the field # not tested
      "Before" => "<", # not tested
      "After" => ">", # not tested
      "On" => "=", # not tested
      "Between" => "" # TODO: this cant be done till some logic is added to forms for a second value field see github issues # not tested
    }
    comparison_conversion[text_operator]
  end

end
