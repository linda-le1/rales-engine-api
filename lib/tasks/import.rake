require 'csv'

desc "Import Merchants"
  task :import => [:environment] do
    file = "./db/data/merchants.csv"
    counter = 0
    CSV.foreach(file, headers: true) do |row|
      merchant_hash = row.to_hash
      merchant = Merchant.create!(merchant_hash)
      counter += 1 if merchant.persisted?
    end
    puts "Created #{counter} merchants!"
  end

