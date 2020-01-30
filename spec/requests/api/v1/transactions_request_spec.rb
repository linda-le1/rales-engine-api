require 'rails_helper'

describe 'Transactions' do
    it 'sends a list of all transactions' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        create_list(:transaction, 5, invoice_id: invoice.id)
        create_list(:transaction, 10, invoice_id: invoice_2.id)

        get '/api/v1/transactions'

        expect(response).to be_successful

        transactions = JSON.parse(response.body)["data"]

        expect(transactions.count).to eql(15)
    end

    it 'can get an invoice by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction = create(:transaction, invoice_id: invoice.id)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        get "/api/v1/transactions/#{transaction.id}"


        invoices = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoices['attributes']['merchant_id']).to eql(merchant.id)
        expect(invoices['attributes']['customer_id']).to eql(customer.id)
        expect(invoices['attributes']['invoice_id']).to eql(invoice.id)
    end
end