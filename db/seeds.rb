User.find_or_create_by(email: 'admin@example.ru') do |f|
  f.password = '123456'
  f.role = 1
end

User.find_or_create_by(email: 'test@example.ru') do |f|
  f.password = '123456'
  f.role = 0
end