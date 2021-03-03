class CsvFilesController < ApplicationController

  before_action :set_csvfile, only: [:show, :edit, :update, :destroy]
  def new
    @csvfile = CsvFile.new
  end

  def create
    @csvfile = CsvFile.new(csvfile_params)
    @csvfile.user = current_user
    if @csvfile.save
      generate_orders(@csvfile.csv_doc)
      redirect_to csv_file_path(@csvfile)
    else
      render :new
    end
  end

  def show
    @csvfile = CsvFile.new
  end

  def destroy
    @csv_file = CsvFile.find(params[:id])
    @csv_file.destroy
    redirect_to csv_files_path
  end

  def index
  end

  private

  def set_csvfile
    @csvfile = CsvFile.find(params[:id])
  end

  def csvfile_params
    params.require(:csv_file).permit(:filename, :csv_doc)
  end

  def generate_orders(csv_doc)
    csv = CSV.parse(csv_doc.download, :headers => true)
    csv.each do |row|
      row = row.to_hash
      row.transform_keys! do |k| 
        newk = k.downcase.gsub(" ", "_")
        k = newk.to_sym
      end
      p row
      Order.create!(row)
    end
  end

end
