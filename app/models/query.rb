class Query < ApplicationRecord
  belongs_to :csv_file
  has_many :filters
  validates :fields, presence: true
  accepts_nested_attributes_for :filters
end
