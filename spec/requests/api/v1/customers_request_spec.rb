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
end