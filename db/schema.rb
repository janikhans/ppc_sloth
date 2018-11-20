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

ActiveRecord::Schema.define(version: 2018_11_20_053351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ad_groups", force: :cascade do |t|
    t.bigint "campaign_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_ad_groups_on_campaign_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.bigint "ad_group_id"
    t.string "text", null: false
    t.integer "match_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_group_id"], name: "index_keywords_on_ad_group_id"
  end

  create_table "search_term_report_items", force: :cascade do |t|
    t.bigint "search_term_report_id"
    t.bigint "ad_group_id"
    t.bigint "keyword_id"
    t.bigint "search_term_id"
    t.date "date"
    t.string "currency"
    t.integer "impressions"
    t.integer "clicks"
    t.integer "click_through_rate"
    t.integer "cost_per_click"
    t.integer "spend"
    t.integer "seven_days_total_sales"
    t.integer "total_advertising_cost_of_sales"
    t.integer "total_return_on_advertising_spend"
    t.integer "seven_day_total_orders"
    t.integer "seven_day_total_units"
    t.integer "seven_day_conversion_rate"
    t.integer "seven_day_advertised_sku_units"
    t.integer "seven_day_other_sku_units"
    t.integer "seven_day_advertised_sku_sales"
    t.integer "seven_day_other_sku_sales"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_group_id"], name: "index_search_term_report_items_on_ad_group_id"
    t.index ["keyword_id"], name: "index_search_term_report_items_on_keyword_id"
    t.index ["search_term_id"], name: "index_search_term_report_items_on_search_term_id"
    t.index ["search_term_report_id"], name: "index_search_term_report_items_on_search_term_report_id"
  end

  create_table "search_term_reports", force: :cascade do |t|
    t.string "name"
    t.boolean "processed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_terms", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ad_groups", "campaigns"
  add_foreign_key "keywords", "ad_groups"
  add_foreign_key "search_term_report_items", "ad_groups"
  add_foreign_key "search_term_report_items", "keywords"
  add_foreign_key "search_term_report_items", "search_term_reports"
  add_foreign_key "search_term_report_items", "search_terms"
end
