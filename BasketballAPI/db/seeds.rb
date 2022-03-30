# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
####
# rails db:reset && heroku pg:reset --confirm gotnext-backend && heroku pg:push jigims_development DATABASE_URL -a gotnext-backend 
require './test/contexts'
require 'base64'

include Contexts 
@user = FactoryBot.create(:user, apple: "jigims", email: "jjigims23@gmail.com", firstname: "JJ", lastname: "Igims", dob: 21.years.ago.to_date, phone: "4123549286")
@user4 = FactoryBot.create(:user, apple: "mjordan", email: "mjordan@gmail.com", firstname: "Michael", lastname: "Jordan", dob: 21.years.ago.to_date, phone: "7248847634")
@user5 = FactoryBot.create(:user, apple: "scurry", email: "scurry@gmail.com", firstname: "Stephen", lastname: "Curry", dob: 21.years.ago.to_date, phone: "6098403925")
@user6 = FactoryBot.create(:user, apple: "ljames", email: "ljames@gmail.com", firstname: "LeBron", lastname: "James", dob: 21.years.ago.to_date, phone: "4128602679")
@user7 = FactoryBot.create(:user, apple: "rwestbrook", email: "rwestbrook@gmail.com", firstname: "Russell", lastname: "Westbrook", dob: 21.years.ago.to_date, phone: "6163078313")
@user8 = FactoryBot.create(:user, apple: "kdurant", email: "kdurant@gmail.com", firstname: "Kevin", lastname: "Durant", dob: 21.years.ago.to_date, phone: "6102336578")
puts("Created users")
img = Base64.encode64(File.open(Rails.root.join("db", "placeholder.png")).read)
encoding = "data:image/png;base64,[#{img}]"
# @user4.image.attach(data: encoding) 

@device = FactoryBot.create(:device, user: @user, platform: "ios", token: "4f191c5fa697cbd821986570183bafa0fed6dd24c064e9ce9752d8278bd65ffe")

@game4 = FactoryBot.create(:game, name: "CMU Game", date: 2.days.from_now.to_date, time: Time.current, description: "a basketball game at Carnegie Mellon University", private: false, longitude: -79.94456661125692, latitude: 40.441405662286684, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game5 = FactoryBot.create(:game, name: "SQH Game", date: 2.days.from_now.to_date, time: Time.current, description: "a basketball game in Squirrel Hill area", private: false, longitude: -79.91960119937258, latitude: 40.43783982874116, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game6 = FactoryBot.create(:game, name: "East Liberty Game", date: Time.current, time: Time.current, description: "a basketball game around East Liberty", private: true, longitude: -79.92535151957483, latitude: 40.46512019696686, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game7 = FactoryBot.create(:game, name: "Walnut Street Game", date: 10.days.from_now.to_date, time: Time.current, description: "a basketball game near Walnut Street", private: true, longitude: -79.92802702164988, latitude: 40.45292700833198, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game8 = FactoryBot.create(:game, name: "Schenley Game", date: 1.days.from_now.to_date, time: Time.current, description: "a basketball game in Schenley Park", private: false, longitude: -79.94180314454185, latitude: 40.43388420368068, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game9 = FactoryBot.create(:game, name: "Highland Park Game", date: 3.days.from_now.to_date, time: Time.current, description: "a basketball game near Highland Park", private: false, longitude: -79.91055195831937, latitude: 40.478308458558075, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game10 = FactoryBot.create(:game, name: "Downtown Game", date: 2.days.from_now.to_date, time: Time.current, description: "a basketball game near downtown", private: true, longitude: -79.99449769090188, latitude: 40.44313694251953, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game11 = FactoryBot.create(:game, name: "Strip District Game", date: 7.days.from_now.to_date, time: Time.current, description: "a basketball game in the Strip District", private: true, longitude: -79.97796435290876, latitude: 40.455008279481326, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game12 = FactoryBot.create(:game, name: "South Oakland Game", date: Time.current, time: Time.current, description: "a basketball game in South Oakland", private: false, longitude: -79.95655401764172, latitude: 40.432195976510776, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game13 = FactoryBot.create(:game, name: "Long Vue Club Game", date: 2.days.from_now.to_date, time: Time.current, description: "a basketball game at Long Vue Club", private: true, longitude: -79.85731965959852, latitude: 40.47960839771666, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
@game14 = FactoryBot.create(:game, name: "Churchill Game", date: 2.days.from_now.to_date, time: Time.current, description: "a basketball game in the Churchill area", private: true, longitude: -79.84334657967321, latitude: 40.44708569655209, shortAddress: "5700 Wilkins Ave", longAddress: "5700 Wilkins Avenue, Pittsburgh, PA")
puts("Created games")

statuses = ["maybe", "going", "invited", "not_going"]
games = [@game4, @game5, @game6, @game7, @game8, @game9, @game10, @game11, @game12, @game13, @game14]
players = []
users = [@user, @user4, @user5, @user6, @user7, @user8]
scope = []
for i in 0..500
    status = statuses[rand(4)]
    game = games[rand(11)]
    user = users[rand(6)]
    potential = [user.id, game.id]
    if !scope.include?(potential)
      player = FactoryBot.create(:player, status: status, user: user, game: game)
      players.append(player)
      scope.append(potential)
    end 
end 
for i in 0..10
    potential = [1, i+1]
    if !scope.include?(potential)
        player = FactoryBot.create(:player, status: "invited", user: @user, game: games[i])
        players.append(player)
        scope.append(potential)
      end 
end 
puts("Created players")

scope = []
favorites = []
for i in 0..64
    user1 = users[rand(6)]
    user2 = users[rand(6)]
    potential = [user1.id, user2.id]
    if user1 != user2 and !scope.include?(potential) 
        favorite = FactoryBot.create(:favorite, favoriter: user1, favoritee: user2)
        favorites.append(favorite)
        scope.append(potential)
    end 
end 
puts("Created favorites")

@user9 = FactoryBot.create(:user, apple: "andyc", email: "andyc@gmail.com", firstname: "Andy", lastname: "Chrvala", dob: 21.years.ago.to_date, phone: "4125929865")
@user10 = FactoryBot.create(:user, apple: "rgainer", email: "rgainer@gmail.com", firstname: "Richard", lastname: "Gainer")
