class Query < ApplicationRecord
  belongs_to :csv_file
  has_many :filters, dependent: :destroy
  validates :fields, presence: true
end
