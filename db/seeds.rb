require 'faker'

# Clean out existing properties and user accounts. 
puts "Cleaning DB..."
Order.destroy_all
CsvFile.destroy_all
User.destroy_all

users = ['alex.terenda@gmail.com', 'jake.howlett@gmail.com', 'louis.leslie@gmail.com', 'yunus.firat@gmail.com', 'filter.test@gmail.com']

address_list = [
  # UK 22
  "4-6 Abingdon Road, Poole, Dorset, BH17 0UG",
  "Campus Manor Childwall Abbey Rd, Merseyside, Liverpool, L16 0JP",
  "18 Ridgeway Close, Lightwater, Surrey, GU18 5XU",
  "Oxney Rd, Peterborough, Cambridgeshire PE1 5YN",
  "12 Burnland Grove, Elrick, Westhill, AB32 6AF",
  "Glenthorne Villas Brownedge Lane, Bamber Bridge, Preston, PR5 6TB",
  "23 College Way, Nottingham, Nottinghamshire NG8 4JH",
  "Clough Mill Grove St, Longwood, Huddersfield, HD3 4TH",
  "5 Marine Parade, Instow, Bideford, EX39 4HY",
  "14 Burntwood Town Shopping Centre Cannock Rd, Burntwood, Staffordshire, WS7",
  "848 Stanley Road, Bounds Green, London SW74 8GL",
  "38 Bowmont Court, Heiton, Kelso, TD5 8JY",
  "83 Upper St, Islington, London, N1 0NU",
  "60 Cross Street, Islington, London, N1 2BA",
  "14 Dagmar Passage, Islington, London, N1 2DN",
  "100 Upper St, Islington, London, N1 0NP",
  "St. Marys Church Upper St, Islington, London, N1 2TX",
  "7 Upper St, Islington, London, N1 0PQ",
  "1 Islington Green, Islington, London, N1 2XH",
  "33 Islington Green, Islington, London, N1 8DU",
  "4 Compton Avenue, Islington, London, N1 2XD",
  "59 Essex Road, Canonbury, London, N1 2SF",
  # US 19
  "4202 Country Dr, Vernon, TX, 76384",
  "16116 33rd Ave, Flushing, NY, 11358",
  "45412 275th St, Parker, SD, 57053",
  "172 Enchanted Oak Ct, Robertsville, MO, 63072",
  "650 W Union St, Benson, AZ, 85602",
  "1201 Willow St, Norristown, PA, 19401",
  "24 W Academy St, Mc Graw, NY, 13101",
  "58 Husted Ln, Greenwich, CT, 06830",
  "1222 June Way, Pasadena, MD, 21122",
  "352 Palmer Road, Ware, MA, 1082",
  "13858 Rt 31 W, Albion, NY, 14411",
  "30 Catskill, Catskill, NY, 12414",
  "85 Crooked Hill Road, Commack, NY, 11725",
  "279 Troy Road, East Greenbush, NY, 12061",
  "2400 Route 9, Fishkill, NY, 12524",
  "990 Route 5 20, Geneva, NY, 14456",
  "656 New Haven Ave, Derby, CT, 6418",
  "495 Flatbush Ave, Hartford, CT, 6106",
  "164 Danbury Rd, New Milford, CT, 6776",
  # Canada 10
  "4526 Av Harvard, Montréal, QC, H4A 2X2",
  "298 Axminster Dr, Richmond Hill, ON, L4C 2W1",
  "220 Newfoundland Dr, St. John's, NL, A1A 3R5",
  "48 Regent St, Guelph, ON, N1E 4W4",
  "41371 Kingswood Rd, Brackendale, BC, V0N",
  "4335 Rue Broadway, Lachine, QC, H8T 1V1",
  "4233 Sutherland Cres, Burlington, ON, L7L 5G3",
  "455 Isabella, St Pembroke, ON, K8A 5T6",
  "34 Hallmark Pl SW, Calgary, AB, T2V 3L1",
  "44 Clyde, Hastings, ON, K0L 1Y0",
  # France 5
  "75 rue du Faubourg National, Thionville,  Lorraine, 57100",
  "89 Avenue De Marlioz, Argenteuil, Île-de-France, 95100",
  "62 Rue de Verdun, MontÉlimar, Rhône-Alpes, 26200",
  "30 Place de la Madeleine, Paris, Île-de-France, 75008",
  "89 Quai des Belges, Maubeuge, Nord-Pas-de-Calais, 59600",
  # Germany 4
  "Leipziger Strasse 20, Osnabrück, Niedersachsen, 49090",
  "Nuernbergerstrasse 69, Altenkrempe, Schleswig-Holstein, 23730",
  "Gruenauer Strasse 39, Himmelpforten, Niedersachsen, 21709",
  "Messedamm 7, Dresden, Freistaat Sachsen, 01002",
  # Italy 5
  "Via Alessandro Farnese 50, Fie Allo Sciliar, Bolzano, 39050",
  "Via Torino 63, Caminata, Piacenza, 29010",
  "Via Pasquale Scura 10, Pomarico, Matera, 75016",
  "Via Castelfidardo 49, Laurignano, Cosenza, 87040",
  "Via Melisurgo 125, Querceta, Lucca, 55046",
  # Spain 3
  "Crta. Cádiz-Málaga 58, Ribesalbes, Castellón, 12210",
  "Herrería 51, Cogollos De La Vega, Granada, 18197",
  "C/ Los Herrán 5, San Vicente De Alcántara, Badajoz, 06500",
  # India 2
  "1520 Kashmere Gate, Delhi, Delhi, 110006",
  "B 805 Avantika Rohini, Delhi, Delhi, 110085",
  # South Africa 4
  "1709 Bad St, Laingsburg, Western Cape, 6901",
  "25 Wattle St, Molteno, Eastern Cape, 5500",
  "2399 Rus St, Paarl, Western Cape, 7624",
  "1751 Oranje St, Aliwal North, Eastern Cape, 9750"
] #74 addresses


financial_status = ["paid", "pending", "refunded"]
subtotals = [0.5, 0.75, 0.9, 5, 10.35, 23, 28, 13.5, 15.6, 24, 26, 38]

users.each do |user|
  puts "Generating account and data for #{user}..."
  user_instance = User.create(email: user, password: "password", password_confirmation: "password")
  csv_file = CsvFile.create(user_id: user_instance.id, filename: "Shoppify Orders")

  lineitemsku = ["VN-03-white-8","VN-09-beige-7", "VN-08-white-6", "C-03-black-8", "DM-02-black-9", "DM-03-red-12"]
  vendors = ["DR MARTENS","VANS","PALLADIUM","NIKE","CONVERSE"]
  shippingname = ["Gabriel Campbell","Colt Patton", "Reed Valencia", "Howard Hahn"]
  orderid = ["3650854682786", "3650854322338", "3650854322332", "3650854322331", "3650854322335"]

  address_list.each_with_index do |full_address, index|
    split_address = full_address.split(",")
    line_one = split_address[0]
    province = split_address[1]
    city = split_address[2]
    zip = split_address[3]
    name = Faker::Name.name
    subtotal = subtotals.sample
    shipping = rand(1..5)

    case index
    when 0..21 then country = "UK"
    when 22..40 then country = "US"
    when 41..50 then country = "Canada"
    when 51..55 then country = "France"
    when 56..59 then country = "Germany"
    when 60..64 then country = "Italy"
    when 65..67 then country = "Spain"
    when 68..69 then country = "India"
    when 70..73 then country = "South Africa"
    else
      country = "UK"
    end
    
    
    order = Order.new(
      
      csv_file_id: csv_file.id,
      name: name,
      email: Faker::Internet.email,
      financial_status: financial_status[rand(0..2)],
      fulfillment_status: "",
      currency: "GBP",
      cancelled_at:  "",
      tags: "egnition-sample-data",
      shipping_company: ["Royal Mail", "Hermes", "DPD", "Yodel"].sample,
      shipping_name: shippingname[rand(0..3)],
      shipping_address1: line_one,
      shipping_address2: "",
      shipping_city: city,
      shipping_province: province,
      shipping_zip: zip,
      shipping_country: country,
      paid_at: Faker::Date.backward(days: 14),
      fulfilled_at: Faker::Date.backward(days: 14),
      accepts_marketing: true,
      subtotal: subtotal,
      shipping: shipping,
      taxes: 0,
      total: subtotal,
      shipping_method: "Standard Shipping Method",
      order_created_at:Faker::Date.backward(days: rand(1..14)),
      billing_street: line_one,
      shipping_street: line_one,
      payment_method: "card",
      refunded_amount: 0,
      vendor: vendors.sample,
      order_id: orderid.sample,
      risk_level: "low",
      source: 1608003,
      lineitem_discount: 0,
      receipt_number: Faker::IDNumber.valid,
      billing_province_name: province,
      shipping_province_name: province,
      discount_code: "ASD Promo",
      discount_amount: 0,
      lineitem_quantity: 1,
      lineitem_price: 0.1,
      lineitem_sku: lineitemsku[rand(0..5)],
      lineitem_requires_shipping: true,
      billing_address1: line_one,
      billing_address2: "",
      billing_city: city,
      lineitem_taxable: true,
      lineitem_fulfillment_status: "pending",
      lineitem_compare_at_price: 0,
      billing_name: name,
      billing_company: vendors[rand(0..4)],
      billing_zip: Faker::Address.zip,
      billing_province: province,
      billing_country: country,
      lineitem_name: vendors[rand(0..4)]
    )
    # order.full_billing_address = "#{order.billing_address1} #{order.billing_address2} #{order.billing_city} #{order.billing_province_name} #{order.billing_country}"
    order.save
  end
end

puts "Creating test queries..."
  csv_id = CsvFile.last.id

  # Int and float tests
  # ----------

  # Int / float: greater than
  query = Query.new(query_name: "Integer greater than", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Greater Than", column_name: "total", value: 10, query_id: query.id)

  # Int / float: less than
  query = Query.new(query_name: "Integer less than", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Less Than", column_name: "total", value: 25, query_id: query.id)

  
  # Int / float: equals
  query = Query.new(query_name: "Integer equals", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Equals", column_name: "total", value: 5, query_id: query.id)
  
  # Int / float: Does not equal
  query = Query.new(query_name: "Integer does not equal", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Does Not Equal", column_name: "total", value: 5, query_id: query.id)
  
  # Int / float: greater than or equals to
  query = Query.new(query_name: "Integer greater than or equal", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Greater Than or Equal To", column_name: "total", value: 5, query_id: query.id)

  # Int / float: less than or equals to
  query = Query.new(query_name: "Integer less than or equal", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Less Than or Equal To", column_name: "total", value: 15, query_id: query.id)

  # Int / float: is empty
  query = Query.new(query_name: "Integer is empty", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Is Empty", column_name: "total", value: "", query_id: query.id)

  # Int / float: is not empty
  query = Query.new(query_name: "Integer is not empty", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Is Not Empty", column_name: "total", value: "", query_id: query.id)

  # Int / float: greater than less than
  query = Query.new(query_name: "Integer greater than less than", fields: "[\"name\", \"total\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Greater Than", column_name: "total", value: 10, query_id: query.id)
  Filter.create(verb: "Where", comparison_operator: "Less Than", column_name: "total", value: 25, query_id: query.id)






  # DateTime tests Broken for now
  # ----------

  # Date before
  # query = Query.new(query_name: "Integer is not empty", fields: "[\"name\", \"order_created_at\"]")
  # query.csv_file_id = csv_id
  # query.save
  # Filter.create(verb: "Where", comparison_operator: "Before", column_name: "total", value: "Mon, 08 Mar 2021", query_id: query.id)
  



  puts "DB seeding complete!"