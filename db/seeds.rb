# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.destroy_all
Comment.destroy_all
User.destroy_all

PASSWORD = "123"
super_user = User.create(
  name: "Admin",
  email: "admin@user.com",
  password: PASSWORD,
)

10.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    name: first_name,
    email: "#{first_name}@#{last_name}.com",
    password: PASSWORD
  )
end

users = User.all

50.times do 
    created_at = Faker::Date.backward(days:365 * 5 )

    p = Post.create(
        title: Faker::Book.title,
        body: Faker::Lorem.paragraph_by_chars(number: 100, supplemental: false),
        created_at: created_at,
        updated_at: created_at,
        user: users.sample        
    )
    if p.valid?
        rand(1..5).times do
            Comment.create(body: Faker::Hacker.say_something_smart, post:p, user: users.sample)
        end
    end
end

posts = Post.all
comments = Comment.all

p "Generated #{posts.count} posts"
p "Generated #{comments.count} comments"
p "Generated #{users.count} users"