class Order < ApplicationRecord
  belongs_to :csv_file
  geocoded_by :full_billing_address
  after_validation :geocode, if: :will_save_change_to_full_billing_address?

  scope :with_scope, -> (array) {where(id: array.map(&:id))}
end
