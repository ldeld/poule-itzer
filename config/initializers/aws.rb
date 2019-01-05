SECRETS = YAML.load Rails::Secrets.read


Aws.config.update({
  region:  'eu-west-3',
  credentials: Aws::Credentials.new(SECRETS['aws_access_key_id'], SECRETS['aws_secret_access_key'])
})
