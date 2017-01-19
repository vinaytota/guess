class FavoriteAnimal < ApplicationRecord
  validates :height, \
            presence: true, \
            numericality: { only_integer: true, greater_than: 0 }
  validates :weight, \
            presence: true, \
            numericality: { only_integer: true, greater_than: 0 }

  # between animal, animal_guess, at least one should be non null
  validates :animal, presence: true, if: proc { |a| a.animal_guess.blank? }
  validates :animal_guess, presence: true, if: proc { |a| a.animal.blank? }

  belongs_to :animal, class_name: 'Animal', optional: true
  belongs_to :animal_guess, class_name: 'Animal', optional: true
end
