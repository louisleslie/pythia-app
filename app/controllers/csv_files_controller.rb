class CsvFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :edit, :update, :destroy]
  def new
    @csv_file = CsvFile.new
  end

  def create
    @csv_file = CsvFile.new(csv_file_params)
    @csv_file.user = current_user
    if @csv_file.save
      redirect_to csv_file_path(@csv_file)
    else
      render :new
    end
  end

  def show
    @csv_file = CsvFile.new
  end

  def destroy
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
end
