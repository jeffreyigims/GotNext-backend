require "apnotic"
module PushService

    def new_connection
        url = "https://api.sandbox.push.apple.com:443"
        cert = Rails.root.join("lib", "notifications", "authkey.p8")
        puts(cert)
        connection = Apnotic::Connection.new(auth_method: :token, cert_path: cert, key_id: "NX5X3NJ8JG", team_id: "5WRQ355X9A", url: url)
        connection.on(:error) { |exception| puts "[INFO] exception has been raised: #{exception}" }
        connection
    end
    
    def send_many(notifications)
        connection = new_connection
        notifications.each do |n|
            push = connection.prepare_push(n)
            push.on(:response) { |r| puts response.status }
            connection.push_async(push)
        end
        connection.join(timeout: 5)
        connection.close
    end

    def send_one(notification)
        connection = new_connection
        push = connection.prepare_push(notification)
        push.on(:response) do |response| 
            # read the response
            puts response.ok?      # => true
            puts response.status   # => '200'
            puts response.headers  # => {":status"=>"200", "apns-id"=>"6f2cd350-bfad-4af0-a8bc-0d501e9e1799"}
            puts response.body     # => ""
        end 
        connection.push_async(push)
        connection.join(timeout: 5)
        connection.close
    end

    def send_push 
        notification = Apnotic::Notification.new("78c9741b1e88d38bc8151144da87b3a571920c1efe3f271191e5560762fbfdf8")
        notification.alert = {
            title:  'You notification title',
            body:   'You notification message.'
        }
        # notification.badge = 1
        # indicates to use notification service extension which auto-increments badge number
        notification.mutable_content = 1
        notification.topic = "com.example.basketball-frontend"
        send_one(notification)
    end 

    def send_push_favorite(favoriter_id, favoritee_id)
        @favoriter = User.find(favoriter_id)
        @device = Device.for_user(favoritee_id).chronological.first
        return unless !@device.nil?
        notification = Apnotic::Notification.new(@device.token)
        notification.alert = {
            title:  "You've been favorited!",
            body:   "#{@favoriter.firstname} has favorited you"
        }
        # notification.badge = 1
        # indicates to use notification service extension which auto-increments badge number
        notification.mutable_content = 1
        notification.topic = "com.example.basketball-frontend"
        # did the favoritee already favorite the favoriter
        favorited = !Favorite.for_users(favoritee_id, favoriter_id).empty?
        notification.custom_payload = {
            "type": "favorite",
            "data": {
                "favorited": favorited
            }
        }
        send_one(notification)
    end 

    def send_game_invite_push(game_id, user_id)
        @game = Game.find(game_id)
        @device = Device.for_user(user_id).chronological.first
        return unless !@device.nil?
        notification = Apnotic::Notification.new(@device.token)
        notification.alert = {
            title:  "You've been invited!",
            body:   "You were invited to #{@game.name}"
        }
        notification.badge = 1
        # indicates to use notification service extension which auto-increments badge number
        notification.mutable_content = 1
        notification.topic = "com.example.basketball-frontend"
        notification.custom_payload = {
            "type": "invite",
            "data": {
                "game_id": game_id
            }
        }
        send_one(notification)
    end 

end

