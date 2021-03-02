class CsvFile < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_one_attached :csv_doc
end
