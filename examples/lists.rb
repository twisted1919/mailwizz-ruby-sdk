# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = Lists.new


# GET ALL ITEMS
response = endpoint.get_lists(page = 1, per_page = 10)

# DISPLAY RESPONSE
puts response.body


# GET ONE ITEM
response = endpoint.get_list('LIST_UID')


# DISPLAY RESPONSE
puts response.body


# CREATE ONE LIST
response = endpoint.create({
                               # required
                               'general': {
                                   'name': 'My list created from the API', # required
                                   'description': 'This is a test list, created from the API.', # required
                               },
                               'defaults': {
                                   'from_name': 'John Doe', # required
                                   'from_email': 'johndoe@doe.com', # required
                                   'reply_to': 'johndoe@doe.com', # required
                                   'subject': 'Hello!',
                               }
                           })


# DISPLAY RESPONSE
puts response.body


# UPDATE ONE LIST
response = endpoint.update('LIST_UID', {
    # required
    'general': {
        'name': 'My list created from the API and now updated', # required
        'description': 'This is a test list, created from the API.', # required
    },
    'defaults': {
        'from_name': 'John Doe', # required
        'from_email': 'johndoe@doe.com', # required
        'reply_to': 'johndoe@doe.com', # required
        'subject': 'Hello!',
    }
})

# DISPLAY RESPONSE
puts response.body


# COPY A LIST
response = endpoint.copy('LIST_UID')

# DISPLAY RESPONSE
puts response.body


# DELETE A LIST
response = endpoint.delete('LIST_UID')

# DISPLAY RESPONSE
puts response.body
