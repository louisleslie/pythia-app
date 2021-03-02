class CsvFilesController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def destroy
    @csv_file = CsvFile.find(params[:id])
    @csv_file.destroy
    redirect_to csv_files_path
  end

  def index
  end
end
