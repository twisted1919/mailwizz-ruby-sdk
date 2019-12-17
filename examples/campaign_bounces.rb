# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = CampaignBounces.new

# GET ALL ITEMS
response = endpoint.get_bounces(campaign_uid = 'CAMPAIGN_UID', page = 1, per_page = 10)

# DISPLAY RESPONSE
puts response.body

# CREATE BOUNCE
response = endpoint.create('CAMPAIGN_UID', {
    # required
    'message': 'The reason why this email bounced',
    'bounce_type': 'hard',
    'subscriber_uid': 'SUBSCRIBER_UID'
})

# DISPLAY RESPONSE
puts response.body
