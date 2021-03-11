class CsvFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :edit, :update, :destroy]
  before_action :get_order_datatypes, only: :show

  def new
    @csv_file = CsvFile.new
  end

  def create
    @csv_file = CsvFile.new(csv_file_params)
    @csv_file.user = current_user
    @csv_file.filename = params[:csv_file]["csv_doc"].original_filename if @csv_file.filename == ""
    if @csv_file.save
      generate_orders(@csv_file)
      redirect_to csv_file_path(@csv_file)
    else
      render :new
    end
  end

  def show
    @orders = Order.connection.select_all("SELECT * FROM Orders WHERE csv_file_id = #{@csv_file.id}")
    respond_to do |format|
      format.html
      format.csv { send_data orders_to_csv(@csv_file.orders, @order_columns.keys), filename: "#{@csv_file.filename}.csv" }
    end
  end

  def destroy
    @csv_file.queries.destroy_all
    @csv_file.orders.destroy_all
    @csv_file.destroy
    redirect_to csv_files_path
  end

  def index
    @csv_files = current_user.csv_files
  end

  private

  def set_csv_file
    @csv_file = CsvFile.find(params[:id])
  end

  def csv_file_params
    params.require(:csv_file).permit(:filename, :csv_doc)
  end

  def generate_orders(csv_file)
    csv = CSV.parse(csv_file.csv_doc.download, :headers => true)
    csv.each do |row|
      row = row.to_hash
      row.transform_keys! do |k| 
        newk = k.downcase.gsub(" ", "_")
        if newk == "created_at"
          k = "order_created_at".to_sym
        elsif newk == "id"
          k = "order_id".to_sym
        else
          k = newk.to_sym
        end
      end
      ord_syms = []
      Order.column_names.each { |col_name| ord_syms << col_name.to_sym }
      row.slice!(*ord_syms)
      row["csv_file_id"] = csv_file.id
      row[:accepts_marketing] = row[:accepts_marketing] == "yes"
      row[:lineitem_requires_shipping] = row[:lineitem_requires_shipping] == "true"
      row[:lineitem_taxable] = row[:lineitem_taxable] == "true"
      o = Order.new(row)
      o.full_billing_address = "#{o.billing_address1} #{o.billing_address2} #{o.billing_city} #{o.billing_province_name} #{o.billing_country}"
      o.save
    end
  end

  def get_order_datatypes
    @order_columns = {}
    Order.columns_hash.map { |k, v| @order_columns[k] = v.sql_type_metadata.type }
  end

  def orders_to_csv(orders, fields)
    fields = fields[5..-1]
    fields.delete("created_at")
    fields.delete("updated_at")
    CSV.generate(headers: true) do |csv|
      csv << fields
      orders.each do |order|
        csv << order.attributes.values_at(*fields)
      end
    end
  end
end
