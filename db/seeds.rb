require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clean out existing properties and user accounts. 
Order.destroy_all
CsvFile.destroy_all
User.destroy_all

users = ['alex.terenda@gmail.com', 'jake.howlett@gmail.com', 'louis.leslie@gmail.com', 'yunus.firat@gmail.com']

users.each do |user|
  u =   User.create(email: user, password: "password", password_confirmation: "password")
end


# financial_status = ["paid", "pending", "refunded"]
# subtotal = [0.1, 0.2, 0.3, ""]
# puts "creating csv file"
# 4.times do 

#    csv_file = CsvFile.new(
#       user_id: User.all.sample.id,
#       filename: Faker::Name.unique.name 
#    )

#    csv_file.save!
# country = Faker::Address.country
# billing_address = "#{Faker::Address.street_address}, #{Faker::Address.city}"
# shippingcity = Faker::Address.city
# shippingzip = Faker::Address.zip
# billingprovince = Faker::Address.state
# lineitemsku = ["VN-03-white-8","VN-09-beige-7", "VN-08-white-6", "C-03-black-8", "DM-02-black-9", "DM-03-red-12"]
# vendors = ["DR MARTENS","VANS","PALLADIUM","NIKE","CONVERSE"]
# name = Faker::Restaurant.name
# shippingname = ["Gabriel Campbell","Colt Patton", "Reed Valencia", "Howard Hahn"]
# orderid = ["3650854682786", "3650854322338", "3650854322332", "3650854322331", "3650854322335"]
#   50.times do
#     order = Order.new(
#       csv_file_id:csv_file.id,
#       name: Faker::Name.name,
#       email: User.all.sample.email,
#       financial_status: financial_status[rand(0..2)],
#       fulfillment_status: "",
#       currency: "GBP",
#       cancelled_at:  "",
#       tags: "egnition-sample-data",
#       shipping_company: name,
#       shipping_name:shippingname[rand(0..3)],
#       shipping_address1:billing_address ,
#       shipping_address2:Faker::Address.full_address,
#       shipping_city:shippingcity ,
#       shipping_province: billingprovince,
#       shipping_zip:shippingzip,
#       shipping_country: country,
#       paid_at:Faker::Date.backward(days: 14),
#       fulfilled_at:Faker::Date.backward(days: 14),
#       accepts_marketing:true,
#       subtotal:subtotal[rand(0..3)],
#       shipping:40.12,
#       taxes:0,
#       total: subtotal[rand(0..3)],
#       shipping_method:"Standard Shipping Method",
#       order_created_at:Faker::Date.backward(days: 14),
#       billing_street:Faker::Address.city,
#       shipping_street:Faker::Address.street_address,
#       payment_method:"card",
#       refunded_amount:0,
#       vendor:vendors[rand(0..4)],
#       order_id:orderid[rand(0..4)],
#       risk_level:"low",
#       source:1608003,
#       lineitem_discount:0,
#       receipt_number:Faker::IDNumber.valid,
#       billing_province_name:billingprovince,
#       shipping_province_name:billingprovince,
#       discount_code:"ASD Promo",
#       discount_amount:0,
#       lineitem_quantity:1,
#       lineitem_price:0.1,
#       lineitem_sku:lineitemsku[rand(0..5)],
#       lineitem_requires_shipping:true,
#       billing_address1:billing_address,
#       billing_address2:Faker::Address.full_address,
#       billing_city:shippingcity,
#       lineitem_taxable:true,
#       lineitem_fulfillment_status:"pending",
#       lineitem_compare_at_price:0,
#       billing_name:name,
#       billing_company:vendors[rand(0..4)],
#       billing_zip: shippingzip,
#       billing_province:billingprovince ,
#       billing_country:country,
#       lineitem_name:vendors[rand(0..4)]

#    )

#    order.save!
# end
# end
# puts "Created!"