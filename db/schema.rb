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

ActiveRecord::Schema.define(version: 2019_06_07_204650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.string "os"
    t.string "cpu"
    t.string "gps"
    t.string "gpu"
    t.string "nfc"
    t.string "ram"
    t.string "sim"
    t.string "usb"
    t.string "edge"
    t.string "gprs"
    t.string "wlan"
    t.string "brand"
    t.string "model"
    t.string "radio"
    t.string "colors"
    t.string "status"
    t.string "chipset"
    t.string "battery"
    t.string "img_url"
    t.string "sensors"
    t.string "weight_g"
    t.string "announced"
    t.string "bluetooth"
    t.string "weight_oz"
    t.string "audio_jack"
    t.string "dimentions"
    t.string "memory_card"
    t.string "display_size"
    t.string "display_type"
    t.string "loud_speaker"
    t.string "network_speed"
    t.string "primary_camera"
    t.string "internal_memory"
    t.string "secondary_camera"
    t.string "display_resolution"
    t.string "network_technology"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand"], name: "index_products_on_brand"
    t.index ["internal_memory"], name: "index_products_on_internal_memory"
    t.index ["model"], name: "index_products_on_model"
    t.index ["os"], name: "index_products_on_os"
    t.index ["price"], name: "index_products_on_price"
    t.index ["ram"], name: "index_products_on_ram"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
