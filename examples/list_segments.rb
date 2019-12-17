# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = ListSegments.new

# GET ALL FIELDS OF A LIST
response = endpoint.get_segments('LIST_UID')

# DISPLAY RESPONSE
puts response.body