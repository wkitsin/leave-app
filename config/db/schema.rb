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

ActiveRecord::Schema.define(version: 20180116074311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leave_applications", force: :cascade do |t|
    t.string "leave_date"
    t.string "approved", default: "N/A"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.index ["user_id"], name: "index_leave_applications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "none"
    t.string "title"
    t.string "department"
    t.string "hod_email"
    t.integer "total_al", default: 0
    t.decimal "bring_forward", precision: 10, scale: 1, default: "0.0", null: false
    t.decimal "replacement_leave", precision: 10, scale: 1, default: "0.0", null: false
    t.decimal "total_leave", precision: 10, scale: 1, default: "0.0", null: false
    t.decimal "leave_taken", precision: 10, scale: 1, default: "0.0", null: false
    t.decimal "balace", precision: 10, scale: 1, default: "0.0", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
