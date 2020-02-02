require 'rails_helper'

describe 'Customers' do
    it 'sends a list of customers' do
        create_list(:customer, 5)

        get '/api/v1/customers'

        expect(response).to be_successful

        customers = JSON.parse(response.body)["data"]

        expect(customers.count).to eql(5)

    end

    it 'can get one customer by its id' do
        id = create(:customer).id
        id_2 = create(:customer).id

        get "/api/v1/customers/#{id}"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful
        expect(customer['attributes']['id']).to eq(id)
        expect(customer['attributes']['id']).not_to eq(id_2)
    end

    it 'can find a customer by their name' do

        customer = create(:customer, name: 'Baby Yoda')

        get "/api/v1/customers/find?name=#{customer.name}"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customer['attributes']['name']).to eql('Baby Yoda')
    end

    it 'can find a customer by their id' do

        customer = create(:customer, id: 888)

        get "/api/v1/customers/find?id=#{customer.id}"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customer['attributes']['id']).to eql(888)
    end

    it 'can find a customer by date created at' do

        customer_1 = create(:customer, created_at: "2009-01-31 01:30:08 UTC")
        customer_2 = create(:customer, created_at: "1998-04-22 01:30:08 UTC")

        get "/api/v1/customers/find?created_at=#{customer_1.created_at}"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customer['attributes']['id']).to eql(customer_1.id)
    end

    it 'can find a customer by date updated at' do

        customer_1 = create(:customer, updated_at: "2009-01-31 01:30:08 UTC")
        customer_2 = create(:customer, updated_at: "1998-04-22 01:30:08 UTC")

        get "/api/v1/customers/find?updated_at=#{customer_1.updated_at}"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customer['attributes']['id']).to eql(customer_1.id)
    end
end