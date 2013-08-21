class User < ActiveRecord::Base
  # Remember to create a migration!
  #attr_accessible :client

  def self.parse_and_create(access_token)
    args = {}
    args[:oauth_token] = access_token.token
    args[:oauth_secret] = access_token.secret
    args[:username] = access_token.params[:screen_name].downcase

    u = User.find_by_username(args[:username])
    u ||= User.create(args)
  end

  def tweet(tweet)
    env = YAML.load_file(APP_ROOT.join('config', 'credentials.yaml'))

    client = Twitter.configure do |config|
      config.consumer_key = env['TWITTER_KEY']
      config.consumer_secret = env['TWITTER_SECRET']
      config.oauth_token = self.oauth_token
      config.oauth_token_secret = self.oauth_secret
    end

    client.update(tweet)
  end

end
