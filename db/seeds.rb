require 'faker'

# Clean out existing properties and user accounts. 
puts "Cleaning DB..."
Order.destroy_all
CsvFile.destroy_all
User.destroy_all

users = ['alex.terenda@gmail.com', 'jake.howlett@gmail.com', 'louis.leslie@gmail.com', 'yunus.firat@gmail.com', 'filter.test@gmail.com']

address_list = [
  # UK 22
  "61 Montpelier Road, Prestonville, Brighton, BN1 2PA",
  "Lockway, Drayton, Oxfordshire, OX14 4LH",
  "Duton Hill Farm, Great Easton, Uttlesford, Essex, CM6 2DZ",
  "Rochfords, Woughton on the Green, Milton Keynes, MK6 5DN",
  "12 Burnland Grove, Elrick, Westhill, AB32 6AF",
  "37, Westbury Hill, Westbury on Trym, Bristol, BS9 3AG",
  "23 College Way, Nottingham, Nottinghamshire NG8 4JH",
  "10 Scotland Street, New Town, Edinburgh, EH3 6PY",
  "4 Nicholson Road, Wadham Park, Oxford, Oxfordshire, OX3 0HW",
  "44 Belvoir Street, Heigham Grove, Norwich, Norfolk, NR2 3AY",
  "66 St Vincent Lane, Blythswood Hill, Glasgow, G2 6DH",
  "2 Blenheim Street, Vauxhall, Liverpool, L5 8SL",
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
  "423rd Avenue, Bon Homme County, South Dakota, 57059, United States"
  "16116 33rd Ave, Flushing, NY, 11358",
  "45412 275th St, Parker, SD, 57053",
  "One Bowdoin Square, New Chardon Street, Boston, MA, 02222",
  "650 W Union St, Benson, AZ, 85602",
  "1201 Willow St, Norristown, PA, 19401",
  "85 Franklin Street, Tribeca, Manhattan, NY, 10013,",
  "58 Husted Ln, Greenwich, CT, 06830",
  "1222 June Way, Pasadena, MD, 21122",
  "352 Palmer Road, Ware, MA, 1082",
  "1144 Sherman Street, Capitol Hill, Denver, CO, 80203",
  "30 Catskill, Catskill, NY, 12414",
  "85 Crooked Hill Road, Commack, NY, 11725",
  "279 Troy Road, East Greenbush, NY, 12061",
  "2400 Route 9, Fishkill, NY, 12524",
  "1056 10th Street, West Oakland, Oakland, CA, 94607",
  "656 New Haven Ave, Derby, CT, 6418",
  "495 Flatbush Ave, Hartford, CT, 6106",
  "164 Danbury Rd, New Milford, CT, 6776",
  # Canada 10
  "4526 Av Harvard, Montreal, QC, H4A 2X2",
  "3642 Henri Julien Ave, Montreal, QC H2X 3H5",# might worky?
  "225 St. Patrick St, Ottawa, ON K1N 5K2",# might worky?
  "Haro Crest Suites, 1246 Haro St, Vancouver, BC V6E 1E7",# might worky?
  "208 W 1st St, North Vancouver, BC V7M 1C9",# might worky?
  "607 10 Ave SW, Calgary, AB T2R 0B2",# might worky?
  "317 St Johns Rd, Toronto, ON M6S 2K3",# might worky?
  "118 Budea Crescent, Scarborough, ON M1R 4W1",# might worky?
  "71 Seaton St, Toronto, ON M5A 2T2",# might worky?
  "526 Markham St, Toronto, ON M6G 2L5",# might worky?
  # France 5
  "75 rue du Faubourg National, Thionville,  Lorraine, 57100",
  "50 Boulevard de Port-Royal, Paris, 75005", # might worky?
  "12-24 Rue Kageneck, Strasbourg, 67000", # might worky?
  "30 Place de la Madeleine, Paris, Île-de-France, 75008", 
  "223 Rue Léon Blum, Montpellier, 34000", # might worky?
  # Germany 4
  "Leipziger Strasse 20, Osnabrück, Niedersachsen, 49090",
  "Klosterstrasse 47, Berlin, 10179", # might worky?
  "Sternengasse 11, Cologne, 50676", # might worky?
  "Hofkamp 161-133, Wuppertal, 42103", # might worky?
  # Italy 5
  "Ramo Cardellina, Cannaregio, Venezia-Murano-Burano, Venice, 30170",
  "6 Via San Giovanni sul Muro, Duomo, Milan, 20121", 
  "Vicolo di San Trifone, Rione V Ponte, Rome, 00186",
  "75 Borgo Pinti, Quartiere 1, Florence, 50121",
  "Palazzo Sassetti, Via degli Anselmi, Florence, 50123",
  # Spain 3
  "19 Calle de Prim, Justicia, Centro, Madrid, 28004",
  "11 Carrer de Jaume Giralt, Sant Pere, Barcelona, 08003",
  "108 Avinguda del Paral·lel, Sant Antoni, Barcelona, 08015",
  # India 2
  "1520 Kashmere Gate, Delhi, Delhi, 110006",
  "B 805 Avantika Rohini, Delhi, Delhi, 110085",
  # South Africa 4
  "1709 Bad St, Laingsburg, Western Cape, 6901",
  "60 Plein Street, Johannesburg, Gauteng, 2000",
  "386 Johannes Ramokhoase Street, Pretoria, Gauteng, 0083",
  "1751 Oranje St, Aliwal North, Eastern Cape, 9750"
] #74 addresses


financial_status = ["paid", "pending", "refunded"]
subtotals = [0.5, 0.75, 0.9, 5, 10.35, 23, 28, 13.5, 15.6, 24, 26, 38]

users.each do |user|
  puts "Generating account and data for #{user}..."
  user_instance = User.create(email: user, password: "password", password_confirmation: "password")
  csv_file = CsvFile.create(user_id: user_instance.id, filename: "Shoppify Orders")

  lineitemsku = ["Shoes White", "Shoes Black", "Shirt Blue", "Jumper Grey", "Tshirt Red", "Tshirt Mint", "Jacket Black"]
  vendors = ["DR MARTENS", "VANS", "PALLADIUM" ,"NIKE", "CONVERSE", "ADIDAS", "RAYBAN", "FRUIT OF THE LOOM", "SUPERDRY"]
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
      total: subtotal, # TODO: Add + shipping here (removed it while testing so i knew what values to expect)
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
      billing_zip: zip,
      billing_province: province,
      billing_country: country,
      lineitem_name: vendors[rand(0..4)]
    )

    order.full_billing_address = full_address
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

  # String tests
  # ----------

  # Exact match
  query = Query.new(query_name: "String matches", fields: "[\"name\", \"billing_city\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Matches", column_name: "billing_city", value: "London", query_id: query.id)

  # Does not match
  query = Query.new(query_name: "String does not match", fields: "[\"name\", \"billing_city\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Does Not Match", column_name: "billing_city", value: "London", query_id: query.id)

  # Contains
  query = Query.new(query_name: "String contains", fields: "[\"name\", \"billing_city\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Contains", column_name: "billing_city", value: "Lon", query_id: query.id)

  # Does not contain
  query = Query.new(query_name: "String does not contain", fields: "[\"name\", \"billing_city\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Does Not Contain", column_name: "billing_city", value: "Lon", query_id: query.id)

  # Starts with
  query = Query.new(query_name: "String starts with", fields: "[\"name\", \"billing_city\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Starts With", column_name: "billing_city", value: "Lon", query_id: query.id)

  # Ends with
  query = Query.new(query_name: "String ends with", fields: "[\"name\", \"billing_city\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Ends With", column_name: "billing_city", value: "on", query_id: query.id)

  # Boolean tests
  # ----------

  # Bool: is true
  # query = Query.new(query_name: "Bool is true", fields: "[\"name\", \"accepts_marketing\"]")
  # query.csv_file_id = csv_id
  # query.save
  # Filter.create(verb: "Where", comparison_operator: "Is True", column_name: "accepts_marketing", value: "", query_id: query.id)

  # Bool: is false



  # DateTime tests
  # ----------

  # Date before
  query = Query.new(query_name: "Date before", fields: "[\"name\", \"order_created_at\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Before", column_name: "order_created_at", value: "2021-03-06T20:47", query_id: query.id)

  # Date after
  query = Query.new(query_name: "Date after", fields: "[\"name\", \"order_created_at\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "After", column_name: "order_created_at", value: "2021-03-01T20:47", query_id: query.id)

  # Date on
  query = Query.new(query_name: "Date on", fields: "[\"name\", \"order_created_at\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "On", column_name: "order_created_at", value: "2021-03-06T00:00", query_id: query.id)

  # Date before and after
  query = Query.new(query_name: "Date before and after", fields: "[\"name\", \"order_created_at\"]")
  query.csv_file_id = csv_id
  query.save
  Filter.create(verb: "Where", comparison_operator: "Before", column_name: "order_created_at", value: "2021-03-06T20:47", query_id: query.id)
  Filter.create(verb: "Where", comparison_operator: "After", column_name: "order_created_at", value: "2021-03-01T20:47", query_id: query.id)

  puts "DB seeding complete!"