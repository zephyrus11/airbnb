CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJYNVTTNRWE5YESXA',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-southeast-1',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'house-rental-for-cheap'                                   # required
  config.fog_public     = false                                                 # optional, defaults to true
  end