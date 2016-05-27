# test-exercise

#How to install

1. `bundle install`
2. `rake db:create`
3. `rake db:schema:load`
4. Ask Joseph for paypal.yml
5. copy past paypal.yml into initializers/paypal.yml

#Errors
If you come accross this error.

`FATAL:  role "yorlook" does not exist`

Its because the postgresql role hadn't been created.

`createuser -s -r yorlook`

Run the the following test: `rspec spec/controllers/orders_controller_spec.rb`


