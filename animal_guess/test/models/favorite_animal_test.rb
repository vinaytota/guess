require 'test_helper'

class FavoriteAnimalTest < ActiveSupport::TestCase
  test 'height not null' do
    fa = FavoriteAnimal.new weight: 30, animal_guess: Animal.first
    assert_not fa.save
    assert_not fa.errors['height'].empty?
  end

  test 'weight not null' do
    fa = FavoriteAnimal.new height: 30, animal_guess: Animal.first
    assert_not fa.save
    assert_not fa.errors['weight'].empty?
  end

  test 'height greater than 0' do
    fa = FavoriteAnimal.new weight: 30, height: -3, animal_guess: Animal.first
    assert_not fa.save
    assert_not fa.errors['height'].empty?
  end

  test 'weight greater than 0' do
    fa = FavoriteAnimal.new weight: -3, height: 30, animal_guess: Animal.first
    assert_not fa.save
    assert_not fa.errors['weight'].empty?
  end

  test 'weight numeric' do
    fa = FavoriteAnimal.new weight: 'blah', height: 30, animal_guess: Animal.first
    assert_not fa.save
    assert_not fa.errors['weight'].empty?
  end

  test 'height numeric' do
    fa = FavoriteAnimal.new weight: 34, height: 'blah', animal_guess: Animal.first
    assert_not fa.save
    assert_not fa.errors['height'].empty?
  end

  test 'animal or animal_guess non null' do
    fa = FavoriteAnimal.new weight: 34, height: 'blah'
    assert_not fa.save
    assert_not fa.errors['animal_guess'].empty?
  end

  test 'animal non null' do
    fa = FavoriteAnimal.new weight: 34, height: 43, animal: Animal.first
    assert fa.save
  end

  test 'animal_guess non null' do
    fa = FavoriteAnimal.new weight: 34, height: 43, animal_guess: Animal.first
    assert fa.save
  end

  test 'animal valid foreign key' do
    fa = FavoriteAnimal.new weight: 34, height: 43, animal_id: 34
    assert_not fa.save
    assert_not fa.errors['animal'].empty?
  end

  test 'animal_guess valid foreign key' do
    fa = FavoriteAnimal.new weight: 34, height: 43, animal_guess_id: 34
    assert_not fa.save
    assert_not fa.errors['animal_guess'].empty?
  end
end
