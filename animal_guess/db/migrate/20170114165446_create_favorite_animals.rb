class CreateFavoriteAnimals < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_animals do |t|
      t.integer :height, null: false
      t.integer :weight, null: false
      t.references :animal_guess, null: true, default: nil, foreign_key: { to_table: :animals }
      t.references :animal, null: true, default: nil, foreign_key: { to_table: :animals }
      t.timestamps
    end
  end
end
