class CsvFile < ApplicationRecord
  belongs_to :user
  has_many :orders
end
