# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = Customers.new

# CREATE CUSTOMER
response = endpoint.create(data = {
    'customer': {
        'first_name': 'John',
        'last_name': 'Doe',
        'email': 'john.doe@doe.com',
        'password': 'superDuperPassword',
        'timezone': 'UTC',
        'birthDate': '1979-07-30'
    },
    # company is optional, unless required from app settings
    'company': {
        'name': 'John Doe LLC',
        'country': 'United States', # see the countries endpoint for available countries and their zones
        'zone': 'New York', # see the countries endpoint for available countries and their zones
        'city': 'Brooklyn',
        'zip_code': 11222,
        'address_1': 'Some Address',
        'address_2': 'Some Other Address',
    },
})

# DISPLAY RESPONSE
puts response.body
