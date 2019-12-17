# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = CampaignsTracking.new


# Track subscriber click for campaign click
response = endpoint.track_url('CAMPAIGN_UID', 'SUBSCRIBER_UID', 'HASH_URL')

# DISPLAY RESPONSE
puts response.body


# Track subscriber open for campaign
response = endpoint.track_opening('CAMPAIGN_UID', 'SUBSCRIBER_UID')

# DISPLAY RESPONSE
puts response.body


# Track subscriber unsubscribe for campaign
response = endpoint.track_unsubscribe('CAMPAIGN_UID', 'SUBSCRIBER_UID', {
    'ip_address': '123.123.123.123',
    'user_agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36',
    'reason': 'Reason for unsubscribe!',
})

# DISPLAY RESPONSE
puts response.body
