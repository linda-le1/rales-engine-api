# Intro

This is a solo project for Mod 3 students. The complete set of directions can be found at https://backend.turing.io/module3/projects/rails_engine_modified.

![](images/rales_engine_schema.png) 

## Instructions

First, clone the directory to a local repository:

`git clone https://github.com/linda-le1/rales-engine-api`

Then, navigate into the project from your terminal:

`cd rales_engine_api`

This project does make use of several gems (see details for more information below) that needs to be bundled:

`bundle install`

Get your database and tables created:

`rails db:create
rails db:migrate`

Run the rake import file to seed your database:

`rake import`

This should have created:
- 100 merchants
- 1000 customers
- 4843 invoices
- 2483 items
- 5595 transactions
- 21687 invoice items

Then run rspec to ensure all of the tests are passing.

## Gems Used

RSPEC gem was used for testing: https://github.com/rspec/rspec.</br>
Shoulda-Matchers were used in addition to the RSPEC testing suite: https://github.com/thoughtbot/shoulda-matchers.</br>
Netflix's fast JSON API gem was used to serialize the information: https://github.com/Netflix/fast_jsonapi.

## Access Endpoints

These endpoints can be accessed locally from your computer. Responses are rendered in JSON with FastAPI serializers.

Start a local server:

`rails s`

Then open a browser and enter "localhost:3000".

### Merchant Endpoints

  `GET` /api/1/merchants<br/>
  `GET` /api/1/merchants/:id<br/>
  `GET` /api/1/merchants/:id/items<br/>
  `GET` /api/1/merchants/:id/invoices<br/>
  `GET` /api/1/merchants/find<br/>
  `GET` /api/1/merchants/find_all<br/>
  `GET` /api/1/merchants/random<br/>
  `GET` /api/1/merchants/most_revenue<br/>
  `GET` /api/1/merchants/revenue<br/>

  ### Customers Endpoints

  `GET` /api/1/customers<br/>
  `GET` /api/1/customers/:id<br/>
  `GET` /api/1/customers/:id/invoices<br/>
  `GET` /api/1/customers/:id/transactions<br/>
  `GET` /api/1/customers/random<br/>
  `GET` /api/1/customers/find<br/>
  `GET` /api/1/customers/find_all<br/>

  ### Items Endpoints

  `GET` /api/1/items<br/>
  `GET` /api/1/items/:id<br/>
  `GET` /api/1/items/:id/invoice_items<br/>
  `GET` /api/1/items/:id/merchant<br/>
  `GET` /api/1/items/random<br/>
  `GET` /api/1/items/find<br/>
  `GET` /api/1/items/find_all<br/>

  ### Invoice Items Endpoints

  `GET` /api/1/invoice_items<br/>
  `GET` /api/1/invoice_items/:id<br/>
  `GET` /api/1/invoice_items/:id/invoice<br/>
  `GET` /api/1/invoice_items/:id/item<br/>
  `GET` /api/1/invoice_items/random<br/>
  `GET` /api/1/invoice_items/find<br/>
  `GET` /api/1/invoice_items/find_all<br/>

  ### Invoices Endpoints

  `GET` /api/1/invoices<br/>
  `GET` /api/1/invoices/:id<br/>
  `GET` /api/1/invoices/:id/transactions<br/>
  `GET` /api/1/invoices/:id/invoice_items<br/>
  `GET` /api/1/invoices/:id/items<br/>
  `GET` /api/1/invoices/:id/customer<br/>
  `GET` /api/1/invoices/:id/merchant<br/>
  `GET` /api/1/invoices/random<br/>
  `GET` /api/1/invoices/find<br/>
  `GET` /api/1/invoices/find_all<br/>

  ### Transaction Endpoints

  `GET` /api/1/transactions<br/>
  `GET` /api/1/transactions/:id/invoice<br/>
  `GET` /api/1/transactions/find<br/>
  `GET` /api/1/transactions/random<br/>
  `GET` /api/1/transactions/find_all<br/>


