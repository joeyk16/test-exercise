# test-exercise

#How to install

1. `bundle install`
2. `rake db:create`
3. `rake db:schema:load`

#Errors
If you come accross this error.

`FATAL:  role "yorlook" does not exist`

Its because the postgresql role hadn't been created.

`createuser -s -r yorlook`

Run the the following test:


