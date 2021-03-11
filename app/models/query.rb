class Query < ApplicationRecord
  belongs_to :csv_file
  has_many :filters, dependent: :destroy
  # validates :query_name, presence: true # Removed for demo
  # validates :fields, presence: true # Removed for demo
  accepts_nested_attributes_for :filters
end
