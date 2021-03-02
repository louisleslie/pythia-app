class CsvFilesController < ApplicationController
  after_save :add_file_rows_to_orders, only [:create]
  
  def new
  end

  def create
  end

  def show
  end

  def destroy
  end

  def index
  end

  private

  def add_file_rows_to_orders(csv_file) # is this the right thing to be parsed?
  end
end
