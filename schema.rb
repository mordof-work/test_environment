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

ActiveRecord::Schema.define(version: 20161228145136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string   "name",                          limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "gshift_url",                    limit: 255
    t.boolean  "is_deleted",                                default: false
    t.boolean  "prevent_login",                             default: false
    t.integer  "banner_account_id"
    t.integer  "leads_platform_cost"
    t.string   "time_zone",                     limit: 255, default: "UTC"
    t.boolean  "has_ecommerce_ga",                          default: false
    t.boolean  "pause_all_keywords",                        default: false
    t.integer  "node_id"
    t.boolean  "clients_treated_like_agencies",             default: false
    t.boolean  "trial"
    t.datetime "last_accessed"
    t.index ["node_id"], name: "index_agencies_on_node_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.integer  "agency_id"
    t.string   "name",                                       limit: 255
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.boolean  "is_deleted",                                             default: false, null: false
    t.integer  "domain_limit"
    t.string   "logo_file_name",                             limit: 255
    t.integer  "account_manager_id"
    t.boolean  "should_remove_agency_branding_from_reports",             default: false
    t.integer  "leads_platform_cost"
    t.boolean  "can_use_locations_for_search_engines"
    t.boolean  "can_use_mobile_search_engines"
    t.boolean  "can_use_social_platforms"
    t.boolean  "is_suspended"
    t.integer  "estimated_usage",                                        default: 0
    t.boolean  "can_use_constant_contact"
    t.string   "time_zone",                                  limit: 255
    t.boolean  "has_ecommerce_ga",                                       default: false
    t.boolean  "can_use_content_performance",                            default: false
    t.integer  "agency_recommendation_template_id"
    t.boolean  "delete_this_now",                                        default: false
    t.integer  "s3_upload_credential_id"
    t.integer  "dropbox_upload_credential_id"
    t.integer  "node_id"
    t.boolean  "billable_client",                                        default: false
    t.boolean  "enforce_keyword_limit"
    t.boolean  "trial"
    t.index ["node_id"], name: "index_clients_on_node_id", using: :btree
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "class_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.text     "plan_summary",             default: "{}"
    t.boolean  "plan_needs_review",        default: true,  null: false
    t.text     "modules",                  default: "{}"
    t.boolean  "is_deleted",               default: false
    t.text     "name"
    t.string   "sitecondor_api_key"
    t.string   "sitecondor_account_type"
    t.integer  "report_custom_label_id"
    t.boolean  "scheduled_reports_paused"
    t.datetime "data_start_date"
  end

  create_table "presences", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "name",                              limit: 255
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.text     "description"
    t.string   "logo_file_name",                    limit: 255
    t.boolean  "is_deleted",                                    default: false, null: false
    t.integer  "default_analytics_web_site_id"
    t.integer  "favorite_search_engine_id"
    t.boolean  "blekko_enabled",                                default: true
    t.boolean  "backlink_estimates_enabled",                    default: false
    t.integer  "keyword_limit"
    t.boolean  "new_backlinks_enabled",                         default: true
    t.integer  "backlink_total_type",                           default: 0
    t.boolean  "backlink_override_allowed",                     default: false
    t.boolean  "include_off_site_in_data",                      default: true
    t.integer  "client_recommendation_template_id"
    t.boolean  "pause_all_keywords",                            default: false
    t.text     "majestic_access_key"
    t.integer  "majestic_verified",                             default: 0
    t.text     "majestic_account_info",                         default: "{}"
    t.integer  "node_id"
    t.boolean  "client_deleted",                                default: false
    t.integer  "favorite_kluster_id"
    t.index ["client_id"], name: "index_presences_client_id", using: :btree
    t.index ["node_id"], name: "index_presences_on_node_id", using: :btree
  end
end
