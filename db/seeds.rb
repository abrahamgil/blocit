# db/seeds.rb

require 'faker'

topics = []
15.times do
  topics << Topic.create(
      name: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph

    )
end
# Create 5 users with their own posts
5.times do
  password = Faker::Lorem.characters(10)
  user = User.new(
  name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  user.skip_confirmation!
  user.save

  # Note: by calling `User.new` instead of `create`,
  # we create an instance of a user which isn't saved to the database.
  # The `skip_confirmation!` method sets the confirmation date
  # to avoid sending an email. The `save` method updates the database.

  5.times do
    post = Post.create(
      user: user,
      topic: topics.first,
      title: Faker::Lorem.sentence, 
      body: Faker::Lorem.paragraph)
    # set the created_at to a time within the past year
    post.update_attribute(:created_at, Time.now - rand(600..31536000))

    topics.rotate!
  end

  posts = Post.all
  5.times do
    comment = Comment.create(
      user: user,
      post: posts.first,
      body: Faker::Lorem.paragraph)
    # set the created_at to a time within the past year
    comment.update_attribute(:created_at, Time.now - rand(600..31536000))

    posts.rotate!
  end

end

admin = User.new(
  name: 'Admin User',
  email: 'admin@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
admin.skip_confirmation!
admin.save
admin.update_attribute(:role, 'admin')

# Create a moderator
moderator = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
moderator.skip_confirmation!
moderator.save
moderator.update_attribute(:role, 'moderator')

# Create a member
member = User.new(
  name: 'Member User',
  email: 'member@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"