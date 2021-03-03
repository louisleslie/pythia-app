class CsvFilesController < ApplicationController

  before_action :set_csvfile, only: [:show, :edit, :update, :destroy]
  def new
    @csv_file = CsvFile.new
  end

  def create
    @csv_file = CsvFile.new(csvfile_params)
    @csv_file.user = current_user
    if @csv_file.save
      generate_orders(@csv_file)
      redirect_to csv_file_path(@csv_file)
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @csv_file = CsvFile.find(params[:id])
    @csv_file.destroy
    redirect_to csv_files_path
  end

  def index
    @csvfiles = current_user.csv_files
  end

  private

  def set_csvfile
    @csv_file = CsvFile.find(params[:id])
  end

  def csvfile_params
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
      p row
      ord_syms = []
      Order.column_names.each { |col_name| ord_syms << col_name.to_sym }
      p ord_syms
      row.slice!(*ord_syms)
      p row
      row["csv_file_id"] = csv_file.id
      p row
      o = Order.new(row)
      p o
      o.save
    end
  end

end
