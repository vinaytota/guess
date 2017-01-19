class GuessController < ApplicationController
  def index
  end

  def make_guess
    height, weight = GuessHelper.height_weight params
    animal_guess_id = GuessHelper.get_guess_id height, weight

    fa = FavoriteAnimal.create!(
      height: height,
      weight: weight,
      animal_guess: Animal.find(animal_guess_id)
    )

    redirect_to confirm_guess_path fa.id
  end

  def confirm_guess
    # As written this performs three queries. I think you could restructure this
    # so it only needs perform a single query but not sure that's really
    # worthwhile

    fa = FavoriteAnimal.includes(:animal_guess).find(params['guess_id'])

    # can't change your answer
    redirect_to(make_guess_path) && return unless fa.animal_id.nil?

    @animal_guess = fa.animal_guess
    @other_animals = Animal.where.not id: @animal_guess.id
  end

  def record_truth
    fa = FavoriteAnimal.includes(:animal_guess).find(params['guess_id'])

    # can't change your answer
    head(500) && return unless fa.animal_id.nil?

    fa.animal_id = Integer(params['animal_id'])
    fa.save
  end
end
