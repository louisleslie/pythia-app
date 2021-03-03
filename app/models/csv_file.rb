require 'csv'

class CsvFile < ApplicationRecord
  belongs_to :user
  has_many :queries, dependent: :destroy
  # validates :csv_doc, :csv => true
  has_one_attached :csv_doc
  has_many :orders
end
