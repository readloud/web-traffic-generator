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

ActiveRecord::Schema.define(version: 20140109170924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "links_counter", default: 0
    t.integer  "status_id"
    t.integer  "subnet_id"
  end

  add_index "domains", ["links_counter"], name: "index_domains_on_links_counter", using: :btree
  add_index "domains", ["status_id"], name: "index_domains_on_status_id", using: :btree
  add_index "domains", ["subnet_id"], name: "index_domains_on_subnet_id", using: :btree
  add_index "domains", ["url"], name: "url", unique: true, using: :btree

  create_table "links", force: true do |t|
    t.integer  "url_id"
    t.integer  "site_id"
    t.string   "link"
    t.string   "anchor"
    t.string   "status",     limit: 25
    t.string   "affiliate",  limit: 5
    t.string   "campaign",   limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["site_id"], name: "index_links_on_site_id", using: :btree
  add_index "links", ["url_id"], name: "index_links_on_url_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "sites", force: true do |t|
    t.string   "code"
    t.string   "domain"
    t.string   "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.string   "day"
    t.integer  "number",     default: 0
  end

  add_index "stats", ["status_id"], name: "index_stats_on_status_id", using: :btree

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "style",      default: ""
  end

  create_table "subnets", force: true do |t|
    t.string   "ip"
    t.integer  "urls_count",    default: 0
    t.integer  "links_count",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "domains_count"
  end

  add_index "subnets", ["domains_count"], name: "index_subnets_on_domains_count", using: :btree
  add_index "subnets", ["links_count"], name: "index_subnets_on_links_count", using: :btree

  create_table "urls", force: true do |t|
    t.string   "url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at"
    t.integer  "internal_links",   default: 0
    t.integer  "external_links",   default: 0
    t.datetime "visited_at"
    t.string   "ip"
    t.string   "subdomain"
    t.string   "domain_authority"
    t.string   "page_authority"
    t.string   "source"
    t.integer  "domain_id"
  end

  add_index "urls", ["domain_id"], name: "index_urls_on_domain_id", using: :btree
  add_index "urls", ["url"], name: "idx1", unique: true, using: :btree
  add_index "urls", ["visited_at"], name: "Visited_at", using: :btree

end
