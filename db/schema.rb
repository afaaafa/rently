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

ActiveRecord::Schema[8.1].define(version: 2026_03_26_230148) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "automoveis", force: :cascade do |t|
    t.string "brand"
    t.datetime "created_at", null: false
    t.string "matricula"
    t.string "model"
    t.string "plate"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["plate"], name: "index_automoveis_on_plate", unique: true
  end

  create_table "contratos_aluguel", force: :cascade do |t|
    t.integer "automovel_id", null: false
    t.string "contract_type"
    t.datetime "created_at", null: false
    t.date "end_date"
    t.integer "pedido_id", null: false
    t.date "start_date"
    t.decimal "total_value", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.index ["automovel_id"], name: "index_contratos_aluguel_on_automovel_id"
    t.index ["pedido_id"], name: "index_contratos_aluguel_on_pedido_id"
  end

  create_table "contratos_credito", force: :cascade do |t|
    t.integer "banco_id", null: false
    t.integer "contrato_aluguel_id", null: false
    t.datetime "created_at", null: false
    t.decimal "credit_value", precision: 10, scale: 2
    t.integer "installments"
    t.decimal "interest_rate", precision: 5, scale: 4
    t.datetime "updated_at", null: false
    t.index ["banco_id"], name: "index_contratos_credito_on_banco_id"
    t.index ["contrato_aluguel_id"], name: "index_contratos_credito_on_contrato_aluguel_id"
  end

  create_table "entidades_empregadoras", force: :cascade do |t|
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.decimal "income"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_entidades_empregadoras_on_client_id"
  end

  create_table "pedidos", force: :cascade do |t|
    t.integer "agent_id"
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.date "request_date", null: false
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_pedidos_on_agent_id"
    t.index ["client_id"], name: "index_pedidos_on_client_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.json "address"
    t.string "bank_code"
    t.string "cnpj"
    t.string "company_name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "name"
    t.string "password_digest", null: false
    t.string "profession"
    t.string "rg"
    t.string "type", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["type"], name: "index_users_on_type"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contratos_aluguel", "automoveis", column: "automovel_id"
  add_foreign_key "contratos_aluguel", "pedidos"
  add_foreign_key "contratos_credito", "contratos_aluguel", column: "contrato_aluguel_id"
  add_foreign_key "contratos_credito", "users", column: "banco_id"
  add_foreign_key "entidades_empregadoras", "users", column: "client_id"
  add_foreign_key "pedidos", "users", column: "agent_id"
  add_foreign_key "pedidos", "users", column: "client_id"
  add_foreign_key "sessions", "users"
end
