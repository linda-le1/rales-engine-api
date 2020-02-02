require 'rails_helper'

describe 'Customers' do
    it 'sends a list of customers' do
        create_list(:customer, 5)

        get '/api/v1/customers'

        expect(response).to be_successful

        customers = JSON.parse(response.body)["data"]

        expect(customers.count).to eql(5)

    end

    it 'can get a specific customer by its id' do
        id = create(:customer).id
        id_2 = create(:customer).id

        get "/api/v1/customers/#{id}"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful
        expect(customer['attributes']['id']).to eq(id)
        expect(customer['attributes']['id']).not_to eq(id_2)
    end

    it 'can find a customer by their first name' do

        customer = create(:customer, first_name: 'Ash', last_name: 'Ketchum')

        get "/api/v1/customers/find?first_name=Ash"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customer['attributes']['first_name']).to eql('Ash')
        expect(customer['attributes']['last_name']).to eql('Ketchum')
    end

    it 'can find a customer by their last name' do

        customer = create(:customer, first_name: 'Ash', last_name: 'Ketchum')

        get "/api/v1/customers/find?last_name=Ketchum"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customer['attributes']['first_name']).to eql('Ash')
        expect(customer['attributes']['last_name']).to eql('Ketchum')
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

    it 'can find customers at random' do
        customers = create_list(:customer, 5)

        ids = customers.map do |customer|
                customer.id
            end

        get '/api/v1/customers/random'

        random_customer = JSON.parse(response.body)

        expect(response).to be_successful

        expect(random_customer.count).to eql(1)

        expect(ids).to include(random_customer['data']['attributes']['id'])
    end

    it 'can find all customers by id' do
        id = create(:customer).id
        id_2 = create(:customer).id

        get "/api/v1/customers/find_all?id=#{id}"

        customer = JSON.parse(response.body)['data']

        expect(response).to be_successful
        expect(customer[0]['attributes']['id']).to eq(id)
    end

    it 'can find all customers by first name' do

        customer = create(:customer, first_name: 'Ash', last_name: 'Ketchum')
        customer_2 = create(:customer, first_name: 'Ash', last_name: 'Pikachu')
        customer_3 = create(:customer, first_name: 'Misty', last_name: 'Staryu')

        get "/api/v1/customers/find_all?first_name=Ash"

        customers = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customers.count).to eql(2)

        expect(customers[0]['attributes']['first_name']).to eql(customer.first_name)
        expect(customers[0]['attributes']['id']).to eql(customer.id)
        expect(customers[1]['attributes']['id']).to eql(customer_2.id)
        expect(customers[1]['attributes']['first_name']).to eql(customer_2.first_name)
    end

    it 'can find all customer by last name' do
        customer_1 = create(:customer, first_name: 'Ash', last_name: 'Ketchum')
        customer_2 = create(:customer, first_name: 'Ash', last_name: 'Pikachu')
        customer_3 = create(:customer, first_name: 'Misty', last_name: 'Ketchum')

        get "/api/v1/customers/find_all?last_name=Ketchum"

        customers = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customers.count).to eql(2)

        expect(customers[0]['attributes']['id']).to eql(customer_1.id)
        expect(customers[1]['attributes']['id']).to eql(customer_3.id)
    end

    it 'can find all customers by date created at' do

        customer_1 = create(:customer, created_at: "2009-01-31 01:30:08 UTC")
        customer_2 = create(:customer, created_at: "2009-01-31 01:30:08 UTC")
        customer_3 = create(:customer, created_at: "1998-04-22 01:30:08 UTC")

        get "/api/v1/customers/find_all?created_at=2009-01-31 01:30:08 UTC"

        customers = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customers.count).to eql(2)

        expect(customers[0]['attributes']['id']).to eql(customer_1.id)
        expect(customers[1]['attributes']['id']).to eql(customer_2.id)
    end

    it 'can find all customers by date updated at' do

        customer_1 = create(:customer, updated_at: "2009-01-31 01:30:08 UTC")
        customer_2 = create(:customer, updated_at: "1998-04-22 01:30:08 UTC")
        customer_3 = create(:customer, updated_at: "1998-04-22 01:30:08 UTC")

        get "/api/v1/customers/find_all?updated_at=1998-04-22 01:30:08 UTC"

        customers = JSON.parse(response.body)['data']

        expect(response).to be_successful

        expect(customers.count).to eql(2)

        expect(customers[0]['attributes']['id']).to eql(customer_2.id)
        expect(customers[1]['attributes']['id']).to eql(customer_3.id)
    end
end