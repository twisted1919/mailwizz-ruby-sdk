# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = ListFields.new

# GET ALL FIELDS OF A LIST
response = endpoint.get_fields('LIST_UID')

# DISPLAY RESPONSE
puts response.body