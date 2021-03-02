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
    @csvfile.destroy
    redirect_to  csv_file_path(@csvfile.user_id)
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
end
