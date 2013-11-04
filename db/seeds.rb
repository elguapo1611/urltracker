# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => "jphillips@opthumb.com", :password => "password", :password_confirmation => "password")

urls = ["http://www.marieclaire.com/hair-beauty/trends/prix-d-excellence-beauty-awards-2013#slide-1",
        "http://www.marthastewart.com/317211/asparagus-leek-and-gruyere-quiche",
        "http://www.elle.com/beauty/makeup-skin-care/best-sweat-proof-beauty-products#slide-1"]
page = Page.new(:url => "http://localhost:3001", 
                     :dom_selectors_attributes => [{:path => "#header h1"}])
page.user = user
page.save!

urls.each do |url|
  page = Page.new(:url => url, 
                     :dom_selectors_attributes => [{:path => "#flipbook"},
                                                   {:path => "#flipbookSlides"}])
  page.user = user
  page.save!
end
