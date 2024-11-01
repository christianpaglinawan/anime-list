# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_10_31_081343) do
  create_table "anime_demographics", force: :cascade do |t|
    t.integer "anime_id", null: false
    t.integer "demographic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_anime_demographics_on_anime_id"
    t.index ["demographic_id"], name: "index_anime_demographics_on_demographic_id"
  end

  create_table "anime_genres", force: :cascade do |t|
    t.integer "anime_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_anime_genres_on_anime_id"
    t.index ["genre_id"], name: "index_anime_genres_on_genre_id"
  end

  create_table "anime_studios", force: :cascade do |t|
    t.integer "anime_id", null: false
    t.integer "studio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_anime_studios_on_anime_id"
    t.index ["studio_id"], name: "index_anime_studios_on_studio_id"
  end

  create_table "animes", force: :cascade do |t|
    t.float "score"
    t.text "description"
    t.string "title"
    t.integer "episodes"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mal_id"
    t.string "image_url"
  end

  create_table "demographics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studios", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "anime_demographics", "animes"
  add_foreign_key "anime_demographics", "demographics"
  add_foreign_key "anime_genres", "animes"
  add_foreign_key "anime_genres", "genres"
  add_foreign_key "anime_studios", "animes"
  add_foreign_key "anime_studios", "studios"
end
