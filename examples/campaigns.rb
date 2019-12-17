# SETUP THE API
require '../examples/setup_api'

# CREATE THE ENDPOINT
endpoint = Campaigns.new


# # GET ALL ITEMS
response = endpoint.get_campaigns(page = 1, per_page = 10)

# # DISPLAY RESPONSE
puts response.body


# # GET ONE ITEM
response = endpoint.get_campaign('CAMPAIGN_UID')

# # DISPLAY RESPONSE
puts response.body


# CREATE ONE CAMPAIGN
response = endpoint.create({
                               'name': 'My API Campaign', # required
                               'type': 'regular', # optional: regular or autoresponder
                               'from_name': 'John Doe', # required
                               'from_email': 'john.doe@doe.com', # required
                               'subject': 'Hey, i am testing the campaigns via API', # required
                               'reply_to': 'john.doe@doe.com', # required
                               'send_at': Time.now.strftime('%Y-%m-%d %H:%M:%S'),
                               # required, this will use the timezone which customer selected
                               'list_uid': 'LIST_UID', # required
                               # 'segment_uid'   : 'SEGMENT-UNIQUE-ID',# optional, only to narrow down

                               # optional block, defaults are shown
                               'options': {
                                   'url_tracking': 'no', # yes | no
                                   'json_feed': 'no', # yes | no
                                   'xml_feed': 'no', # yes | no
                                   'plain_text_email': 'yes', # yes | no
                                   'email_stats': nil, # a valid email address where we should send the stats after campaign done

                                   # - if autoresponder uncomment bellow:
                                   # 'autoresponder_event'            : 'AFTER-SUBSCRIBE', # AFTER-SUBSCRIBE or AFTER-CAMPAIGN-OPEN
                                   # 'autoresponder_time_unit'        : 'hour', # minute, hour, day, week, month, year
                                   # 'autoresponder_time_value'       : 1, # 1 hour after event
                                   # 'autoresponder_open_campaign_id' : 1, # INT id of campaign, only if event is AFTER-CAMPAIGN-OPEN,

                                   # - if this campaign is advanced recurring, you can set a cron job style frequency.
                                   # - please note that this applies only for regular campaigns.
                                   # 'cronjob'         : '0 0 * * *', # once a day
                                   # 'cronjob_enabled' : 1, # 1 or 0
                               },

                               # required block, archive or template_uid or content : required.
                               # the templates examples can be found here: Examples
                               'template': {
                                   # 'archive': File.read('template-example.zip'),
                                   # # 'template_uid': 'template_uid',
                                   'content': File.read('template-example.html'),
                                   'inline_css': 'no', # yes | no
                                   # 'plain_text': nil, # leave empty to auto generate
                                   'auto_plain_text': 'yes', # yes | no
                               },
                           })
# DISPLAY RESPONSE
puts response.body

#
# # UPDATE ONE CAMPAIGN
response = endpoint.update('CAMPAIGN_UID', {
    'name': 'My API Campaign - UPDATED', # required
    'from_name': 'John Doe', # required
    'from_email': 'john.doe@doe.com', # required
    'subject': 'Hey, i am testing the campaigns via API', # required
    'reply_to': 'john.doe@doe.com', # required
    'send_at': Time.now.strftime('%Y-%m-%d %H:%M:%S'),
    # required, this will use the timezone which customer selected
    'list_uid': 'LIST_UID', # required
    # 'segment_uid'   : 'SEGMENT-UNIQUE-ID',# optional, only to narrow down

    # optional block, defaults are shown
    'options': {
        'url_tracking': 'no', # yes | no
        'json_feed': 'no', # yes | no
        'xml_feed': 'no', # yes | no
        'plain_text_email': 'yes', # yes | no
        'email_stats': nil, # a valid email address where we should send the stats after campaign done

        # - if autoresponder uncomment bellow:
        # 'autoresponder_event'            : 'AFTER-SUBSCRIBE', # AFTER-SUBSCRIBE or AFTER-CAMPAIGN-OPEN
        # 'autoresponder_time_unit'        : 'hour', # minute, hour, day, week, month, year
        # 'autoresponder_time_value'       : 1, # 1 hour after event
        # 'autoresponder_open_campaign_id' : 1, # INT id of campaign, only if event is AFTER-CAMPAIGN-OPEN,

        # - if this campaign is advanced recurring, you can set a cron job style frequency.
        # - please note that this applies only for regular campaigns.
        # 'cronjob'         : '0 0 * * *', # once a day
        # 'cronjob_enabled' : 1, # 1 or 0
    },

    # required block, archive or template_uid or content : required.
    # the templates examples can be found here: Examples
    'template': {
        # 'archive': File.read('template-example.zip'),
        'template_uid': 'TEMPLATE_UID',
        # 'content': File.read('template-example.html'),
        'inline_css': 'no', # yes | no
        # 'plain_text': nil, # leave empty to auto generate
        'auto_plain_text': 'yes', # yes | no
    },
})

# # DISPLAY RESPONSE
puts response.body


# # COPY ONE CAMPAIGN
response = endpoint.copy('CAMPAIGN_UID')

# # DISPLAY RESPONSE
puts response.body


# # MARK ONE CAMPAIGN AS SENT
response = endpoint.mark_sent('CAMPAIGN_UID')

# # DISPLAY RESPONSE
puts response.body


# # PAUSE/UNPAUSE ONE CAMPAIGN
response = endpoint.pause_unpause('CAMPAIGN_UID')

# # DISPLAY RESPONSE
puts response.body


# # DELETE ONE CAMPAIGN
response = endpoint.delete('CAMPAIGN_UID')

# # DISPLAY RESPONSE
puts response.body
