require '../mailwizz/mailwizz'

include Mailwizz
include Endpoint

# noinspection SpellCheckingInspection
config = Config.new({
                        'api_url': 'http://MAILWIZZ_APP/api/index.php',
                        'public_key': 'PUBLIC_KEY',
                        'private_key': 'PRIVATE_KEY',
                        'charset': 'utf-8'
                    })

# now inject the configuration and we are ready to make api calls
Base.config = config