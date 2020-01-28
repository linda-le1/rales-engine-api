require 'csv'

desc "Import Merchants"
  task :import => [:environment] do
    file = "./db/data/merchants.csv"

    counter = 0

    CSV.foreach(file, headers: true) do |row|
      merchant_hash = row.to_hash
      merchant = Merchant.create(merchant_hash)
      counter += 1 if merchant.persisted?
    end

    puts "Created #{counter} merchants!"
  end

  task :import => [:environment] do
    file = "./db/data/customers.csv"

    counter = 0

    CSV.foreach(file, headers: true) do |row|
      customer_hash = row.to_hash
      customer = Customer.create(customer_hash)
      counter += 1 if customer.persisted?
    end

    puts "Created #{counter} customers!"
  end

  task :import => [:environment] do
    file = "./db/data/invoices.csv"

    counter = 0

    CSV.foreach(file, headers: true) do |row|
      invoice_hash = row.to_hash
      invoice = Invoice.create(invoice_hash)
      counter += 1 if invoice.persisted?
    end

    puts "Created #{counter} invoices!"
  end

  task :import => [:environment] do
    file = "./db/data/items.csv"

    counter = 0

    CSV.foreach(file, headers: true) do |row|
      item_hash = row.to_hash
      item = Item.create(item_hash)
      counter += 1 if item.persisted?
    end

    puts "Created #{counter} items!"
  end

  task :import => [:environment] do
    file = "./db/data/transactions.csv"

    counter = 0

    CSV.foreach(file, headers: true) do |row|
      transaction_hash = row.to_hash
      transaction = Transaction.create(transaction_hash)
      counter += 1 if transaction.persisted?
    end

    puts "Created #{counter} transactions!"
  end

  task :import => [:environment] do
    file = "./db/data/invoice_items.csv"

    counter = 0

    CSV.foreach(file, headers: true) do |row|
      invoice_items_hash = row.to_hash
      invoice_item = InvoiceItem.create(invoice_items_hash)
      counter += 1 if invoice_item.persisted?
    end

    puts "Created #{counter} invoice_items!"
  end

