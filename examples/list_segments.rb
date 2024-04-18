# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = ListSegments.new

# GET ALL SEGMENTS OF A LIST
response = endpoint.get_segments('LIST_UID')

# DISPLAY RESPONSE
puts response.body

# GET ONE LIST SEGMENT
response = endpoint.get_segment('LIST_UID', 'SEGMENT_UID')

# DISPLAY RESPONSE
puts response.body

# GET ONE LIST SEGMENT SUBSCRIBERS
response = endpoint.get_subscribers('LIST_UID', 'SEGMENT_UID', page = 1, per_page = 10)

# DISPLAY RESPONSE
puts response.body