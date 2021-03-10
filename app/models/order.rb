class Order < ApplicationRecord
  belongs_to :csv_file
  geocoded_by :full_billing_address
  after_validation :geocode, if: :will_save_change_to_full_billing_address?

  def self.to_csv(header_fields)
    CSV.generate(headers: true) do |csv|
      csv << header_fields
      all.each do |order|
        order.attributes.values_at(*header_fields)
      end
    end
  end
end
