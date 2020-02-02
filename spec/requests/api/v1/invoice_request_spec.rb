require 'rails_helper'

describe 'Invoices' do
    it 'sends a list of all invoices' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        create_list(:invoice, 5, merchant_id: merchant.id, customer_id: customer.id)
        create_list(:invoice, 4, merchant_id: merchant_2.id, customer_id: customer_2.id)

        get '/api/v1/invoices'

        expect(response).to be_successful

        invoices = JSON.parse(response.body)["data"]

        expect(invoices.count).to eql(9)
    end

    it 'can get a specific invoice by its id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoices = create_list(:invoice, 2, merchant_id: merchant_2.id, customer_id: customer_2.id)
        invoice_3 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        get "/api/v1/invoices/#{invoice_3.id}"

        invoices = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoices['attributes']['id']).to eql(invoice_3.id)
    end

    it 'can find an invoice by id' do
        merchant = create(:merchant)

        customer = create(:customer)

        invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        get "/api/v1/invoices/find?id=#{invoice_1.id}"

        invoice = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice['attributes']['id']).to eql(invoice_1.id)
    end

    it 'can find an invoice by customer id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        get "/api/v1/invoices/find?customer_id=#{invoice_1.customer_id}"

        invoice = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice['attributes']['id']).to eql(invoice_1.id)
        expect(invoice['attributes']['merchant_id']).to eql(merchant.id)
    end

    it 'can find an invoice by merchant id' do
        merchant = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)
        customer_2 = create(:customer)

        invoices = create_list(:invoice, 2, merchant_id: merchant_2.id, customer_id: customer_2.id)
        invoice_3 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

        get "/api/v1/invoices/find?merchant_id=#{invoice_3.merchant_id}"

        invoice = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice['attributes']['merchant_id']).to eql(merchant.id)
        expect(invoice['attributes']['id']).to eql(invoice_3.id)
    end

    it 'can find an invoice by shipped status' do
        merchant = create(:merchant)

        customer = create(:customer)

        invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, status: 'cancelled')

        get "/api/v1/invoices/find?status=#{invoice_1.status}"

        invoice = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice['attributes']['id']).to eql(invoice_1.id)
    end

    it 'can find an invoice by created at date' do
        merchant = create(:merchant)

        customer = create(:customer)

        invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2019-04-22 01:30:08 UTC")
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: "2019-04-22 01:30:08 UTC")

        get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"

        invoice = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice['attributes']['id']).to eql(invoice_1.id)
    end
    it 'can find an invoice by updated at ' do
        merchant = create(:merchant)

        customer = create(:customer)

        invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, updated_at: "2019-04-22 01:30:08 UTC")
        invoice_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, updated_at: "2019-04-22 01:30:08 UTC")

        get "/api/v1/invoices/find?updated_at=#{invoice_1.updated_at}"

        invoice = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(invoice['attributes']['id']).to eql(invoice_1.id)
    end

end