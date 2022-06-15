class musify::V1::UsersController < ApplicationController
    def create
        # this will help us get the access codes
        body = {
            grant_type: 'authorization_code',
            code: params[:code],
            client_id: ENV['SPOTIFY_CLIENT_KEY'],
            client_secret:  ENV['SPOTIFY_SECRET_KEY'],
            redirect_uri: ENV['REDIRECT_URI'],
        }
        
        auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
        # converts to json
        auth_params = JSON.parse(auth_response.body)
        # construct header for access token for user
        header = { Authorization: "Bearer #{auth_params['access_token']}" }
        
        user_response = RestClient.get("https://api.spotify.com/v1/me", header)
        #converts to json
        user_params = JSON.parse(user_response.body)
        #we give the user information based off the parameters given 
        @user = User.find_or_create_by(
            username: user_params["id"],
            spotify_url: user_params["external_urls"]["spotify"],
            href: user_params["href"],
            uri: user_params["uri"]
        )
        @user.update(access_token:auth_params["acces_token"]), refresh_token: auth_params["refresh_token"]

       #placeholder to check if we could successfully go through these steps
       redirect_to "http://emilioroche.github.io/sucess"
        

        