##Tweet Now! Mult-user

Building on Tweet Now! 1: Single User, let's add support for logging in with Twitter. This will be our first application that uses OAuth for authentication.

Here's the application skeleton that you should use that has already implemented the nasty OAuth bits. Unless you're feeling incredibly ambitious, you should use it as a starting point for your multi-user Tweet Now! app.

####Configure Your Enviornment
Assuming you've configured things properly, the skeleton app should just run out of the box. However, the skeleton app doesn't do anything related to creating the user, logginer her in, etc. You'll need to implement that part on your own later. For now, though, just make sure the application skeleton works (which will prove that your environment and Twitter application are configured correctly).

####Implement the Last Step
Now you'll need to implement that last step of the OAuth flow. Specifically, you'll need to create the new user, set her as "logged in", store her access token and secret along with her user record, etc. This should happen inside of the /auth route in your controllers/index.rb file:

          get '/auth' do
            # the `request_token` method is defined in `app/helpers/oauth.rb`
            @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
            # our request token is only valid until we use it to get an access token, so let's delete it from our session
            session.delete(:request_token)

            # at this point in the code is where you'll need to create your user account and store the access token

            erb :index
          end
We'll want a User model, however the user won't have a password. Instead, the user will be authenticated via OAuth. With OAuth there's not necessarily a distinction between signing up and logging in — the first time a user authenticates via Twitter we can create the User object. Instead of a password, you'll want to have columns to store her "access token" and "access token secret".
