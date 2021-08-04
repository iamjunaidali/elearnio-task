c1 = Coach.create!(name: "Adam")
c2 = Coach.create!(name: "Bart")
c3 = Coach.create!(name: "Patrick")

10.times do |i|
  c1.courses.create!(name: "#{c1.name}-Course#{i+1}")
  c2.courses.create!(name: "#{c2.name}-Course#{i+1}")
  c3.courses.create!(name: "#{c3.name}-Course#{i+1}")
end

c1.courses.each do |course|
  10.times do |i|
    course.activities.create!(name: "#{course.name}-Activity#{i+1}")
  end
end

c2.courses.each do |course|
  10.times do |i|
    course.activities.create!(name: "#{course.name}-Activity#{i+1}")
  end
end

c3.courses.each do |course|
  10.times do |i|
    course.activities.create!(name: "#{course.name}-Activity#{i+1}")
  end
end
