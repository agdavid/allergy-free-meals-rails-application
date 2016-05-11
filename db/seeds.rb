allergen_list = [
  "Dairy",
  "Eggs",
  "Fish",
  "Shellfish",
  "Tree Nuts",
  "Peanuts",
  "Wheat",
  "Soy"
]

allergen_list.each do |allergen|
  a = Allergen.new
  a.name = allergen 
  a.save
end

# sight_list = {
#     "Washington Monument" => {
#       :description => "Towering tribute to George Washington"
#     },
#     "National Mall" => {
#       :description => "Historical memorial parks on a promenade"
#     }
#   }
# sight_list.each do |name, sight_hash|
#   s = Sight.new
#   s.name = name
#   sight_hash.each do |attribute, value|
#       s[attribute] = value
#   end
#   s.save
# end
