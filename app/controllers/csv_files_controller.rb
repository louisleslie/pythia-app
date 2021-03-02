require 'csv'
class CsvFilesController < ApplicationController

  before_action :set_csvfile, only: [:show, :edit, :update, :destroy]
  def new
    @csvfile = CsvFile.new
  end

  def create
    @csvfile = CsvFile.new(csvfile_params)
    @csvfile.user = current_user
    if @csvfile.save
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

  def add_file_rows_to_orders(csv_file) # is this the right thing to be parsed?
    csv_text = File.read(csv_file.)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Order.create!(row.to_hash)
    end
  end
end
