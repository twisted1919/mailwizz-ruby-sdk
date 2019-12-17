# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = Templates.new


# GET ONE ITEM
response = endpoint.get_template(template_uid = 'TEMPLATE_UID')

# DISPLAY RESPONSE
puts response.body


# GET ALL TEMPLATES
response = endpoint.get_templates(page = 1, per_page = 10)

# DISPLAY RESPONSE
puts response.body


# SEARCH FOR TEMPLATES
response = endpoint.search_templates(page = 1, per_page = 10, filters = {
    'name': 'example-template'
})

# DISPLAY RESPONSE
puts response.body


# CREATE ONE TEMPLATE
response = endpoint.create(data = {
    'name': 'My API template ',
    # 'content': '<body>Hello</body>',
    # 'content': File.read('template-example.html'),
    # 'archive': File.read('template-example.zip'), - TODO - Request entity too large for zip in all the endpoints
    'inline_css': 'no', # yes|no
})

# DISPLAY RESPONSE
puts response.body


# UPDATE ONE TEMPLATE
response = endpoint.update(template_uid = 'TEMPLATE_UID', data = {
    'name': 'My API template - Updated',
    # 'content': open('template-example.html', 'rb').read(),
    # 'archive': open('template-example.zip', 'rb').read(),
    'inline_css': 'no', # yes|no
})

# DISPLAY RESPONSE
puts response.body


# DELETE A TEMPLATE
response = endpoint.delete('TEMPLATE_UID')

# DISPLAY RESPONSE
puts response.body
