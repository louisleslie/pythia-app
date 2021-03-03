class CsvFile < ApplicationRecord
  belongs_to :user
  has_many :queries
  # validates :csv_doc, :csv => true
  has_one_attached :csv_doc
  has_many :orders
  #after_save :generate_orders
end
