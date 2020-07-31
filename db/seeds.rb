ActiveRecord::Base.transaction do
  user = User.create!(
    email: 'user@example.com',
    password: '123456'
  )

  library = Library.create!(name: '戸田市立図書館', crawler: 'Crawler::TodaCrawler')
  user.library_users.create!(library: library, sign_in_id: '3546058', password: 'nhc4')

  library = Library.create!(name: '中央区立図書館', crawler: 'Crawler::ChuoCrawler')
  user.library_users.create!(library: library, sign_in_id: '003386786', password: '78671704')

  library = Library.create!(name: '江東区立図書館', crawler: 'Crawler::KotoCrawler')
  user.library_users.create!(library: library, sign_in_id: '006770242', password: 'xmsq84')

  library = Library.create!(name: '江戸川区立図書館', crawler: 'Crawler::EdogawaCrawler')
  user.library_users.create!(library: library, sign_in_id: '9005499104', password: 'lib8848')

  library = Library.create!(name: '品川区立図書館', crawler: 'Crawler::ShinagawaCrawler')
  user.library_users.create!(library: library, sign_in_id: '16086884', password: 'book8848')
end
