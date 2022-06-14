class User < ApplicationRecord
    has_many :track_users
    has_many :tracks, through: :track_users

    validates :username, uniqueness: true, presence :true
    #checks if time is more than 50 minutes old
    def access_token_expired?
        (Time.now - self.updated_at) > 3000
    end

    def refresh_access_token
        # Check if user's access token has expired
        if access_token_expired?
          #Request a new access token using refresh token
          #Create body of request
          body = {
            grant_type: "refresh_token",
            refresh_token: self.refresh_token,
            client_id: ENV['SPOTIFY_CLIENT_KEY'],
            client_secret: ENV["SPOTIFY_SECRET_KEY"]
          }
          # Send request and updated user's access_token
          auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
          auth_params = JSON.parse(auth_response)
          self.update(access_token: auth_params["access_token"])
        else
          puts "Current user's access token has not expired"
        end
      end
end
