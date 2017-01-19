# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dog = Animal.create!(name: 'Dog')
cat = Animal.create!(name: 'Cat')

# training_data.csv is loosely based on https://www.kaggle.com/miroslavsabo/young-people-survey
# but only contains the subset of columns which we may find useful here
# Description of the columns in order:
# Height in cm
# Weight in kg
# favorite animal (made up based on "Dangerous Dog" column in original data)

file_path = File.join(Rails.root, 'db', 'training_data.csv')
File.open(file_path) do |file|
  file.readline # discard CSV header
  until file.eof?
    line = file.readline
    line_split = line.split(',')
    height_in = (Integer(line_split[0]) * 0.39).round # convert cm to in
    weight_lbs = (Integer(line_split[1]) * 2.2).round # convert kg to lbs

    dog_or_cat = line_split[2].strip
    if dog_or_cat == 'DOG'
      favorite_animal = dog
    elsif dog_or_cat == 'CAT'
      favorite_animal = cat
    end

    puts "Inserting row with #{weight_lbs}lb, #{height_in}, #{dog_or_cat}"

    # if this needs to be faster, this could be changed to bulk insert all rows at once
    #  at once instead of inserting each row individually
    FavoriteAnimal.create! \
      weight: weight_lbs, height: height_in, animal: favorite_animal

  end
end
