# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = Countries.new

# GET ALL ITEMS
response = endpoint.get_countries(page = 1, per_page = 10)

# DISPLAY RESPONSE
puts response.body

# GET COUNTRY ZONES
response = endpoint.get_zones(country_id = 223, page = 1, per_page = 10)

# DISPLAY RESPONSE
puts response.body

