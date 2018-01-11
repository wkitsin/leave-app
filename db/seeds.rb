# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'employee_listing.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
	t = User.new 
	t.email = row['EMAIL']
	t.password = '123123'
	t.password_confirmation = '123123'
	t.title = row['TITLE']
	t.department = row['DEPARTMENT']
	t.hod_email = row['HOD_EMAIL']
  t.total_al = row['2018_TOTAL_AL']
  t.total_leave = row['2018_TOTAL_AL']
  t.balace = row['2018_TOTAL_AL']
  t.save 

end

User.where(email: ['r.chong@buro247.my', 'k.tan@imv.com.sg', 'cm.khoo@buro247.my', 
  'j.teh@imv.com.sg', 'v.loo@imv.com.sg', 'sh.pang@imv.com.sg', 's.khu@imv.com.sg', 
  'azreezalhafidz@staiil.my']).update(role: 'admin')
