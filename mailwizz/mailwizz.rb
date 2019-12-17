module Mailwizz
  VERSION_CODE = '1.0.0'
end

require_relative 'base'
require_relative 'config'
require_relative 'client'
require_relative 'request'
require_relative 'endpoint/campaign_bounces'
require_relative 'endpoint/campaigns'
require_relative 'endpoint/campaigns_tracking'
require_relative 'endpoint/countries'
require_relative 'endpoint/customers'
require_relative 'endpoint/list_fields'
require_relative 'endpoint/list_segments'
require_relative 'endpoint/list_subscribers'
require_relative 'endpoint/lists'
require_relative 'endpoint/templates'
require_relative 'endpoint/transactional_emails'
