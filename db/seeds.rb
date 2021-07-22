# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Link.create({
  icon_url: "icons/github_small.png",
  linkable_type: "User",
  linkable_id: "1",
  url: "https://github.com/toastynerd",
  description: "github"
})

Link.create({
  icon_url: "icons/li_small.png",
  linkable_type: "User",
  linkable_id: "1",
  url: "https://www.linkedin.com/in/tyler-morgan-b3a82853/",
  description: "linkedin"
})
