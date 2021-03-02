require 'csv'
class CsvFilesController < ApplicationController
  after_save :add_file_rows_to_orders, only: [ :create ]

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
    csv_text = File.read(csv_file.)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Order.create!(row.to_hash)
    end

  end
end
