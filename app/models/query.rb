class Query < ApplicationRecord
  belongs_to :file
  has_many :filters

  validates :fields, presence: true
end
