# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# sizes = ["small", "medium","large"]
# 3.times do 1000.times do Locker.create(...

Locker.create(size: "small",  is_available: false, name: "Barnacle Bob")
Locker.create(size: "small",  is_available: false, name: "Captain Obvious")
Locker.create(size: "small",  is_available: true,  name: "Captain Swanky Stockings")
Locker.create(size: "small",  is_available: true,  name: "Captain Tommy Toenails")
Locker.create(size: "medium", is_available: true,  name: "Bootleg Bill")
Locker.create(size: "medium", is_available: true,  name: "Peg Legged Penny")
Locker.create(size: "medium", is_available: true,  name: "Swashbuckling Susan")
Locker.create(size: "large",  is_available: true,  name: "Captain Underpants")
Locker.create(size: "large",  is_available: true,  name: "Long John Larry")
Locker.create(size: "large",  is_available: true,  name: "One Eyed Jack")