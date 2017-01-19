# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170114165446) do

  create_table "animals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_animals_on_name", unique: true, using: :btree
  end

  create_table "favorite_animals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "height",          null: false
    t.integer  "weight",          null: false
    t.integer  "animal_guess_id"
    t.integer  "animal_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["animal_guess_id"], name: "index_favorite_animals_on_animal_guess_id", using: :btree
    t.index ["animal_id"], name: "index_favorite_animals_on_animal_id", using: :btree
  end

  add_foreign_key "favorite_animals", "animals"
  add_foreign_key "favorite_animals", "animals", column: "animal_guess_id"
end
