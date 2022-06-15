class Musify::V1::LoginController < ApplicationController
    def spotify_auth
        query_params = {
            client_id: ENV['SPOTIFY_CLIENT_KEY'],
            response_type: 'code',
            redirect_uri: ENV['REDIRECT_URI'],
            scope: 'user-library-read user-library-modify user-top-read user-modify-playback-state playlist-modify-public playlist-modify-private ugc-image-upload user-read-recently-played',
            show_dialog: true
        }
        url = 'https://accounts.spotify.com/authorize/'
        redirect_to "#{url}?#{query_params.to_query}"
    end

    def authorized_user
        render json: {
            username: current_user.username,
        }
    end
end