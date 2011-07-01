User.all.each {|r| r.destroy }
Club.all.each {|r| r.destroy }
Newspaper.delete_all
City.delete_all


(1..100).to_a.each_with_index do |i,e|
  User.create!(:data => {:year => 1900 + i, :music => 'rock, jazz'},
  :first_name => Faker::Name.first_name,
  :last_name => Faker::Name.last_name,
  :active => true,
  :age => 1 + i,
  :description => Faker::Lorem.paragraph,
  :born_at =>  Time.now)
end

# ensure that 20 users do not have any phone numbers
User.limit(80).each do |u|
  2.times do
    u.phone_numbers.create!(:number => Faker::PhoneNumber.phone_number)
  end
  u.create_website(:url => 'http://www.' + Faker::Internet.domain_name)
  u.clubs.create!(:name => Faker::Company.name)
end

# ensure that 30 users do not have cars
User.limit(70).each do |u|
  u.cars.create!(:name => 'Honda')
end

n = Newspaper.new(:name => 'DC Experss')
n.paper_id = 'dc_express'
n.save!

n = Newspaper.new(:name => 'NYC Experss')
n.paper_id = 'nyc_express'
n.save!

City.create(:name => 'seattle')
City.create(:name => 'nyc')
City.create(:name => 'miami')

puts "City records: " + City.count.to_s
puts "User records: " + User.count.to_s
puts "Newspaper records: " + Newspaper.count.to_s
puts "Club records: " + Club.count.to_s
