# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Comment.all.destroy_all
Post.all.destroy_all
User.all.destroy_all

admin =
  User.create!(
    name: 'Steve Jones',
    password: 'password',
    email: 'stevejones@yahoo.com',
    uid: '65dss5fd6sfsd56fsd56f2',
    role: 1
  )
normalUser =
  User.create!(
    name: 'Just Aguy',
    password: 'password',
    uid: '1251235211325',
    email: 'justaguy@email.com'
  )
firstPost =
  Post.create!(
    user_id: admin.id,
    content: Faker::Markdown.sandwich(sentences: 5, repeat: 1)
  )
secondPost =
  Post.create!(
    user_id: admin.id,
    content: Faker::Markdown.sandwich(sentences: 5, repeat: 1)
  )
thirdPost =
  Post.create(
    user_id: admin.id,
    content: Faker::Markdown.sandwich(sentences: 5, repeat: 1)
  )
fourthPost =
  Post.create(
    user_id: admin.id,
    content: Faker::Markdown.sandwich(sentences: 5, repeat: 1)
  )
commentOne =
  Comment.create!(
    post_id: thirdPost.id,
    user_id: normalUser.id,
    content: Faker::Markdown.sandwich(sentences: 5, repeat: 1)
  )
