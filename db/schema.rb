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

ActiveRecord::Schema[7.2].define(version: 2025_06_07_175230) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analysis_sessions", force: :cascade do |t|
    t.string "session_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "balance_sheets", force: :cascade do |t|
    t.bigint "financial_document_id", null: false
    t.decimal "assets"
    t.decimal "liabilities"
    t.decimal "equity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["financial_document_id"], name: "index_balance_sheets_on_financial_document_id"
  end

  create_table "calculations", force: :cascade do |t|
    t.string "metric"
    t.decimal "value"
    t.text "explanation"
    t.bigint "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_calculations_on_session_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "analysis_session_id", null: false
    t.string "role"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_session_id"], name: "index_chat_messages_on_analysis_session_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "inn"
    t.string "name"
    t.text "contact_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inn"], name: "index_companies_on_inn", unique: true
  end

  create_table "financial_documents", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "document_type"
    t.date "report_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "report_date"], name: "index_financial_documents_on_company_id_and_report_date"
    t.index ["company_id"], name: "index_financial_documents_on_company_id"
  end

  create_table "metric_results", force: :cascade do |t|
    t.bigint "analysis_session_id", null: false
    t.string "metric"
    t.string "value"
    t.text "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_session_id"], name: "index_metric_results_on_analysis_session_id"
  end

  create_table "profit_losses", force: :cascade do |t|
    t.bigint "financial_document_id", null: false
    t.decimal "revenue"
    t.decimal "net_profit"
    t.decimal "ebitda"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["financial_document_id"], name: "index_profit_losses_on_financial_document_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploaded_documents", force: :cascade do |t|
    t.string "file"
    t.bigint "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_uploaded_documents_on_session_id"
  end

  add_foreign_key "balance_sheets", "financial_documents"
  add_foreign_key "calculations", "sessions"
  add_foreign_key "chat_messages", "analysis_sessions"
  add_foreign_key "financial_documents", "companies"
  add_foreign_key "metric_results", "analysis_sessions"
  add_foreign_key "profit_losses", "financial_documents"
  add_foreign_key "uploaded_documents", "sessions"
end
