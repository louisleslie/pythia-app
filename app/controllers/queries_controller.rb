require 'json'

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
    query_results = generate_query(@query)
    @display_query = query_results[0] + query_results[2].sub("AND", "WHERE")
    sql_query = query_results.join(" ")
    @results = Order.connection.select_all(sql_query)
    @query_orders = Order.find_by_sql(sql_query)
  end

  def new
    @query = Query.new
    @query.filters.build
    @order_data_types = {}
    @filter_comparisons = []
    Order.columns_hash.map { |k, v| @order_data_types[k] = "#{k}-#{v.sql_type_metadata.type}" }
  end

  def create
    @query = Query.new(query_params)
    @query.fields = params[:query][:fields][1..-1].to_s
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
    @order_data_types = {}
    Order.columns_hash.map { |k, v| @order_data_types[k] = "#{k}-#{v.sql_type_metadata.type}" }
    @filter_comparisons = []
    @query.filters.each { |filter| @filter_comparisons << filter.comparison_operator }
    p @filter_comparisons
    @checked_fields = JSON.parse(@query.fields)[1..-1]
  end

  def update
    @csv_file = @query.csv_file
    @query.filters.destroy_all
    @query.update(query_params)
    @query.fields = params[:query][:fields][1..-1].to_s
    @query.save
    @order_data_types = {}
    Order.columns_hash.map { |k, v| @order_data_types[k] = "#{k}-#{v.sql_type_metadata.type}" }
    redirect_to csv_file_query_path(@query)
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
    parsed_fields = JSON.parse(query.fields)
    formatted_fields = parsed_fields.flatten.join(", ")
    formatted_fields = "*" if formatted_fields.split(",").count == 61 # TODO: find a more dynamic way to do this
    csv_id = query.csv_file_id
    base_query = "SELECT #{formatted_fields} FROM orders"
    file_query = "WHERE csv_file_id = #{csv_id}"
    converted_query_filters = []

    query.filters.each do |filter|
      verb = filter.verb.upcase
      column = filter.column_name.split("-")[0]
      operator = convert_operator(filter.comparison_operator, column)
      if filter.value.nil?
        value = ""
      elsif filter.value.match(/T\d{2}:\d{2}/)
        value = "'#{filter.value.split("T")[0]}'"
        column = "#{column}::date"
      elsif filter.comparison_operator == "Contains" || filter.comparison_operator == "Does Not Contain"
        value = "'%#{filter.value}%'"
      elsif filter.comparison_operator == "Starts With"
        value = "'#{filter.value}%'"
      elsif filter.comparison_operator == "Ends With"
        value = "'%#{filter.value}'"
      elsif filter.comparison_operator == "Matches" || filter.comparison_operator == "Does Not Match"
        value = "'#{filter.value}'"
      else
        value = filter.value
      end
      if filter.comparison_operator == "Is Empty" || filter.comparison_operator == "Is True" || filter.comparison_operator == "Is False"
        converted_query_filters << " #{verb} #{column} #{operator}"
      else
        converted_query_filters << " #{verb} #{column} #{operator} #{value}"
      end
    end

    # TODO: Currently this only handles WHERE verbs I havent added the logic for group by yet
    generated_query = converted_query_filters.join.gsub("WHERE", "AND")

    return [base_query, file_query, generated_query]
  end

  def convert_operator(text_operator, column)
    comparison_conversion = {
      "Equals" => "=",
      "Does Not Equal" => "<>",
      "Greater Than" => ">",
      "Less Than" => "<",
      "Greater Than or Equal To" => ">=",
      "Less Than or Equal To" => "<=",
      "Is Empty" => "IS NULL", # TODO: expand this to pick up empty strings ""
      "Is Not Empty" => "IS NOT NULL", # TODO: expand this to pick up empty strings ""
      "Is True" => "= 'yes' OR #{column} = 'true' OR #{column} = '1'", # not tested
      "Is False" => "= 'no' OR #{column} = 'false' OR #{column} = '0'", # not tested
      "Contains" => "ILIKE",
      "Does Not Contain" => "NOT ILIKE",
      "Starts With" => "ILIKE",
      "Ends With" => "ILIKE",
      "Before" => "<",
      "After" => ">",
      "On" => "=",
      "Matches" => "ILIKE",
      "Does Not Match" => "NOT ILIKE"
    }
    comparison_conversion[text_operator]
  end

end
