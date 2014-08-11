User.delete_all
Article.delete_all
Comment.delete_all
Vote.delete_all

puts 'Seeding random records...'
FactoryGirl.create_list(:article, 32).each do |article|
  print '.'
  FactoryGirl.create_list(:vote, rand(16), votable: article, user: User.offset(rand(32)).first)
  rand(8).times do
    comment = FactoryGirl.create(:comment, article: article, user: User.offset(rand(32)).first)
    FactoryGirl.create_list(:vote, rand(8), votable: comment, user: User.offset(rand(32)).first)
  end
end
puts
