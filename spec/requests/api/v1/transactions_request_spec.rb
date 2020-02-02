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

    it 'can get a specific transaction by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, credit_card_number: '1111', invoice_id: invoice.id)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        get "/api/v1/transactions/#{transaction_1.id}"


        transaction = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(transaction['attributes']['invoice_id']).to eql(invoice.id)
        expect(transaction['attributes']['credit_card_number']).to eql('1111')
        expect(transaction['attributes']['credit_card_number']).not_to eql(transaction_2.credit_card_number)
    end

    it 'can find a specific transaction by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, credit_card_number: '1111', invoice_id: invoice.id, id: 888)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id, id: 1234)

        get "/api/v1/transactions/find?id=#{transaction_1.id}"


        transaction = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(transaction['attributes']['id']).to eql(invoice.id)
    end

    it 'can find a specific transaction by its invoice id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, credit_card_number: '1111', invoice_id: invoice.id)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        get "/api/v1/transactions/find?invoice_id=#{transaction_1.invoice_id}"


        transaction = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(transaction['attributes']['id']).to eql(transaction_1.id)
    end

    it 'can find a specific transaction by credit card number' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, credit_card_number: '1111', invoice_id: invoice.id)
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        get "/api/v1/transactions/find?credit_card_number=#{transaction_1.id}"


        transaction = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(transaction['attributes']['id']).to eql(transaction_1.id)
    end

    it 'can find a specific transaction by status' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, credit_card_number: '88881234', invoice_id: invoice.id, status: 'failed')
        transaction_2 = create(:transaction, invoice_id: invoice_2.id, status: 'success')

        get "/api/v1/transactions/find?status=#{transaction_2.id}"

        transaction = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(transaction['attributes']['id']).to eql(transaction_2.id)
    end

    it 'can find a specific transaction by date created' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, credit_card_number: '1111', invoice_id: invoice.id, created_at: "2019-01-31 01:30:08 UTC")
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        get "/api/v1/transactions/find?created_at=#{transaction_1.id}"


        transaction = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(transaction['attributes']['id']).to eql(transaction_1.id)
    end

    it 'can find a specific transaction by date updated' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)

        transaction_1 = create(:transaction, credit_card_number: '1111', invoice_id: invoice.id, updated_at: "2019-01-31 01:30:08 UTC")
        transaction_2 = create(:transaction, invoice_id: invoice_2.id)

        get "/api/v1/transactions/find?updated_at=#{transaction_1.id}"


        transaction = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(transaction['attributes']['id']).to eql(transaction_1.id)
    end

end