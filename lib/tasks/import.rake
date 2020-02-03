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

  task :import=> [:environment] do
    file = "./db/data/items.csv"

    counter = 0

    items = CSV.foreach(file, headers: true)
    items.each do |row|
      Item.create!({
        id: row['id'],
        name: row['name'],
        description: row['description'],
        unit_price: row['unit_price'].to_f/100,
        merchant_id: row['merchant_id'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      })
      end

    puts "Created items!"
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

    invoice_items = CSV.foreach(file, headers: true)
    invoice_items.each do |row|
      InvoiceItem.create!({
          id: row['id'],
          item_id: row['item_id'],
          invoice_id: row['invoice_id'],
          unit_price: row['unit_price'].to_f/100,
          quantity: row['quantity'],
          created_at: row['created_at'],
          updated_at: row['updated_at'],
        })

      end

    puts "Created invoice_items!"
  end

