class CsvFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :edit, :update, :destroy]
  
  def new
    @csv_file = CsvFile.new
  end

  def create
    @csv_file = CsvFile.new(csv_file_params)
    @csv_file.user = current_user
    unless @csv_file.filename
      @csv_file.filename = params[:csv_file]["csv_doc"].original_filename
    end
    if @csv_file.save
      generate_orders(@csv_file)
      redirect_to csv_file_path(@csv_file)
    else
      render :new
    end
  end

  def show
    @orders = Order.connection.select_all("SELECT * FROM Orders WHERE csv_file_id = #{@csv_file.id}")
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
      o = Order.new(row)
      o.save
    end
  end

end
