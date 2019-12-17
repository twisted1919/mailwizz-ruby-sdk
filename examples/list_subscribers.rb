# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = ListSubscribers.new


# GET ALL SUBSCRIBERS OF A LIST
response = endpoint.get_subscribers(list_uid = 'LIST_UID', page = 1, per_page = 10)


# DISPLAY RESPONSE
puts response.body


# GET ONE SUBSCRIBER FROM A LIST
response = endpoint.get_subscriber(list_uid = 'LIST_UID', subscriber_uid = 'SUBSCRIBER_UID')


# DISPLAY RESPONSE
puts response.body


# SEARCH BY EMAIL
response = endpoint.email_search(list_uid = 'LIST_UID', email_address = 'john.doe@example.com')


# DISPLAY RESPONSE
puts response.body


# SEARCH BY EMAIL IN ALL LISTS
response = endpoint.email_search_all_lists(email_address = 'john.doe@example.com')


# DISPLAY RESPONSE
puts response.body


# SEARCH BY CUSTOM FIELDS IN A LIST
response = endpoint.search_by_custom_fields(list_uid = 'LIST_UID', fields = {
    'EMAIL': 'john.doe@example.com'
}, page = 1, per_page = 10)


# DISPLAY RESPONSE
puts response.body


# ADD SUBSCRIBER
response = endpoint.create(list_uid = 'LIST_UID', data = {
    'EMAIL': 'john.doe@example.com', # the confirmation email will be sent!!! Use valid email address
    'FNAME': 'John',
    'LNAME': 'Doe'
})


# DISPLAY RESPONSE
puts response.body


# ADD SUBSCRIBERS IN BULK (since MailWizz 1.8.1)
response = endpoint.create_bulk(list_uid = 'LIST_UID', data = [
    {
        'EMAIL': 'john.doe1111@example.com', # the confirmation email will be sent!!! Use valid email address
        'FNAME': 'John111',
        'LNAME': 'Doe111'
    },
    {
        'EMAIL': 'john.doe2222@example.com', # the confirmation email will be sent!!! Use valid email address
        'FNAME': 'John222',
        'LNAME': 'Doe222'
    },
    {
        'EMAIL': 'john.doe3333@example.com', # the confirmation email will be sent!!! Use valid email address
        'FNAME': 'John333',
        'LNAME': 'Doe333'
    },
])


# DISPLAY RESPONSE
puts response.body


# UPDATE EXISTING SUBSCRIBER
response = endpoint.update(list_uid = 'LIST_UID', subscriber_uid = 'SUBSCRIBER_UID', data = {
    'EMAIL': 'john.doe.updated@example.com', # the confirmation email will be sent!!! Use valid email address
    'FNAME': 'John Updated',
    'LNAME': 'Doe Updated'
})


# DISPLAY RESPONSE
puts response.body


# CREATE / UPDATE EXISTING SUBSCRIBER
response = endpoint.create_update(list_uid = 'LIST_UID', data = {
    'EMAIL': 'john.doe@example.com', # the confirmation email will be sent!!! Use valid email address
    'FNAME': 'John Updated ah',
    'LNAME': 'Doe Updated'
})


# DISPLAY RESPONSE
puts response.body


# UNSUBSCRIBE existing subscriber, no email is sent, unsubscribe is silent
response = endpoint.unsubscribe(list_uid = 'LIST_UID', subscriber_uid = 'SUBSCRIBER_UID')


# DISPLAY RESPONSE
puts response.body


# UNSUBSCRIBE existing subscriber by email address, no email is sent, unsubscribe is silent
response = endpoint.unsubscribe_by_email(list_uid = 'LIST_UID', email_address = 'john.doe@example.com')


# DISPLAY RESPONSE
puts response.body


# UNSUBSCRIBE existing subscriber by email address from all lists, no email is sent, unsubscribe is silent
response = endpoint.unsubscribe_by_email_from_all_lists(email_address = 'john.doe@example.com')


# DISPLAY RESPONSE
puts response.body


# DELETE SUBSCRIBER, no email is sent, delete is silent
response = endpoint.delete(list_uid = 'LIST_UID', subscriber_uid = 'SUBSCRIBER_UID')


# DISPLAY RESPONSE
puts response.body


# DELETE SUBSCRIBER by email address, no email is sent, delete is silent
response = endpoint.delete_by_email(list_uid = 'LIST_UID', email_address = 'john.doe@example.com')


# DISPLAY RESPONSE
puts response.body
