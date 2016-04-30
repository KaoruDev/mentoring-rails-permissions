me = User.create!(email: 'me@gmail.com', password: 'password')

User.create!(email: 'buddy@gmail.com', password: 'password')
anon = User.create!(email: 'anon@gmail.com', password: 'password')

10.times do
  post = Post.create!(user: [me, anon].sample, title: Faker::Book.title, body: Faker::ChuckNorris.fact)
  puts "Created post for: #{post.user.email}"
end
