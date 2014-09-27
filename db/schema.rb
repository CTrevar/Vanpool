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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140926175054) do

  create_table "ciudads", :force => true do |t|
    t.string   "clave",      :limit => 45
    t.string   "nombre",     :limit => 100
    t.boolean  "estauts"
    t.integer  "pais_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "ciudads", ["pais_id"], :name => "index_ciudads_on_pais_id"

  create_table "clientes", :force => true do |t|
    t.integer  "puntaje"
    t.integer  "nivel"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "pais", :force => true do |t|
    t.string   "clave",      :limit => 45
    t.string   "nombre",     :limit => 100
    t.string   "divisa",     :limit => 10
    t.boolean  "estatus"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "ruta", :force => true do |t|
    t.string   "nombre",     :limit => 45
    t.string   "gmaps"
    t.string   "precio",     :limit => 45
    t.string   "kilometros", :limit => 45
    t.boolean  "estatus"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "heir_id"
    t.string   "heir_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "vans", :force => true do |t|
    t.string   "placa",               :limit => 45
    t.string   "modelo",              :limit => 45
    t.integer  "capacidad"
    t.date     "fecha_compra"
    t.integer  "kilometro_recorrido"
    t.boolean  "activa"
    t.boolean  "estatus"
    t.integer  "pais_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "vans", ["pais_id"], :name => "index_vans_on_pais_id"

  create_table "zonas", :force => true do |t|
    t.string   "clave",      :limit => 45
    t.string   "nombre",     :limit => 100
    t.boolean  "estauts"
    t.integer  "ciudad_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "zonas", ["ciudad_id"], :name => "index_zonas_on_ciudad_id"

end
