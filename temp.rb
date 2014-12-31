(5..25).each do |i|
  u = User.find(i)
  #u.runs.create(runtype: :walk, distance: i + 0.5)
  u.total_distance = i + 0.5
  u.save
end
#20.times do |i|
#  name =  Faker::Name.first_name
#  User.create!(first_name: name, last_name: Faker::Name.last_name, password:'dandandan', email: "dan.arrington+#{name}@gmail.com")
#end


