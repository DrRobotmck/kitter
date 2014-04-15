# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
    id: 5,
    username: "joeschmoe",
    name: "joe",
    email: "joe@schmoe.com",
    background_photo_url: "jpeg.jpeg",
    profile_photo_url: "jpeg.jpg",
    bio: "just yr avg joe",
    website: "avejoe.com",
    verified: true,
    location: "NYC",
    password: "factory88",
    password_confirmation: "factory88",
    country_id: 1)


User.create(
    id: 1,
    username: "samschmoes",
    name: "sam",
    email: "sam@schmoe.com",
    background_photo_url: "jpeg.jpeg",
    profile_photo_url: "jpeg.jpg",
    bio: "just yr avg sam",
    website: "avesam.com",
    verified: false,
    location: "NYC",
    password: "factory88",
    password_confirmation: "factory88",
    country_id: 1)

