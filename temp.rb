(8..28).each do |i|
  u = User.find(i)
  u.runs.create(runtype: :walk, distance: i + 0.5)
end

