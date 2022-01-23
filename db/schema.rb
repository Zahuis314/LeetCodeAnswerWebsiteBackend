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

ActiveRecord::Schema.define(version: 2022_01_22_222545) do

  create_table "problem_similarities", force: :cascade do |t|
    t.integer "source_id"
    t.integer "target_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["source_id", "target_id"], name: "index_problem_similarities_on_source_id_and_target_id", unique: true
    t.index ["target_id", "source_id"], name: "index_problem_similarities_on_target_id_and_source_id", unique: true
  end

  create_table "problems", force: :cascade do |t|
    t.string "title", null: false
    t.integer "difficulty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title_slug", null: false
    t.boolean "is_paid_only", default: false, null: false
    t.string "question_id", null: false
    t.string "question_frontend_id", null: false
    t.float "ac_rate"
    t.index ["difficulty"], name: "index_problems_on_difficulty"
    t.index ["question_frontend_id"], name: "index_problems_on_question_frontend_id", unique: true
    t.index ["question_id"], name: "index_problems_on_question_id", unique: true
    t.index ["title"], name: "index_problems_on_title", unique: true
    t.index ["title_slug"], name: "index_problems_on_title_slug", unique: true
  end

  create_table "problems_topic_tags", id: false, force: :cascade do |t|
    t.integer "problem_id", null: false
    t.integer "topic_tag_id", null: false
    t.index ["problem_id", "topic_tag_id"], name: "index_problems_topic_tags_on_problem_id_and_topic_tag_id"
    t.index ["topic_tag_id", "problem_id"], name: "index_problems_topic_tags_on_topic_tag_id_and_problem_id"
  end

  create_table "topic_tags", force: :cascade do |t|
    t.string "gql_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gql_id"], name: "index_topic_tags_on_gql_id", unique: true
    t.index ["name"], name: "index_topic_tags_on_name", unique: true
    t.index ["slug"], name: "index_topic_tags_on_slug", unique: true
  end

end
