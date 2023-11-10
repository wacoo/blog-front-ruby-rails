require 'faker'

# Create 10 users
10.times do
  User.create(
    name: Faker::Name.name,
    photo: Faker::Avatar.image,
    bio: Faker::Lorem.paragraph(sentence_count: 2),
    posts_counter: 0
  )
end

# Create 100 posts
100.times do
  Post.create(
    author_id: rand(1..10),
    title: Faker::Lorem.sentence(word_count: 3),
    text: Faker::Lorem.paragraph(sentence_count: 3),
    comments_counter: 0,
    likes_counter: 0
  )
end

# Create 1000 comments
1000.times do
  Comment.create(
    user_id: rand(1..10),
    post_id: rand(1..100),
    text: Faker::Lorem.paragraph(sentence_count: 2)
  )
end