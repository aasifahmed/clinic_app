# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170309061835) do

  create_table "appointments", force: :cascade do |t|
    t.string   "patient_name",         limit: 50,  default: "0", null: false
    t.string   "file_no",              limit: 255
    t.integer  "age",                  limit: 4
    t.boolean  "sex"
    t.string   "nationality",          limit: 255
    t.string   "visit_type",           limit: 255
    t.datetime "appointment_time"
    t.string   "cash",                 limit: 255
    t.integer  "insurance_company_id", limit: 4
    t.integer  "doctor_id",            limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "appointments", ["doctor_id"], name: "index_appointments_on_doctor_id", using: :btree
  add_index "appointments", ["insurance_company_id"], name: "index_appointments_on_insurance_company_id", using: :btree

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "insurance_companies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "patient_details", force: :cascade do |t|
    t.string   "file_no",      limit: 255
    t.string   "name",         limit: 255
    t.string   "age",          limit: 255
    t.string   "mobile",       limit: 255
    t.string   "nationality",  limit: 255
    t.string   "payment_mode", limit: 255
    t.string   "doctor",       limit: 255
    t.datetime "visit_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "insurance_companies"
end
