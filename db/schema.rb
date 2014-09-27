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

<<<<<<< HEAD
<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20140921051624) do
=======
ActiveRecord::Schema.define(:version => 20140925163115) do
>>>>>>> bbe988770409e80f7e6c8acf72c8150a9ac74846

  create_table "administradors", :force => true do |t|
    t.string   "nombreUsuario"
    t.string   "emailUsuario"
    t.integer  "idTipoUsuario"
    t.string   "facebookidUsuario"
    t.string   "openpayidUsuario"
    t.string   "nombrePilaUsuario"
    t.string   "apellidoPaterno"
    t.string   "apellidoMaterno"
    t.datetime "fechaNacimiento"
    t.boolean  "estatusUsuario"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end
<<<<<<< HEAD
>>>>>>> jTables
=======
>>>>>>> bbe988770409e80f7e6c8acf72c8150a9ac74846
=======
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
>>>>>>> crud_vans

  create_table "clientes", :force => true do |t|
    t.integer  "puntaje"
    t.integer  "nivel_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.string   "kilometros"
    t.integer  "kilometraje"
  end

  create_table "estadotipos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "medallas", :force => true do |t|
    t.integer  "tipomedalla_id"
    t.string   "nombre"
    t.integer  "puntos"
    t.string   "imagen"
    t.boolean  "estatus"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "medallasmuros", :force => true do |t|
    t.integer  "cliente_id"
    t.integer  "medalla_id"
    t.boolean  "cobrado"
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

<<<<<<< HEAD
  create_table "nivels", :force => true do |t|
    t.string   "nombre"
    t.integer  "rangomaximo"
    t.boolean  "estatus"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
=======
  create_table "pais", :force => true do |t|
    t.string   "clave",      :limit => 45
    t.string   "nombre",     :limit => 100
    t.string   "divisa",     :limit => 10
    t.boolean  "estatus"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
>>>>>>> crud_vans
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

<<<<<<< HEAD
  create_table "reservacions", :force => true do |t|
    t.integer  "viaje_id"
    t.integer  "cliente_id"
    t.integer  "referenciapago_id"
    t.integer  "estadotipo_id"
    t.boolean  "estatus"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "ruta", :force => true do |t|
    t.integer  "conductor_id"
    t.integer  "van_id"
    t.string   "nombre"
    t.string   "gmaps"
    t.string   "precio"
    t.integer  "kilometros"
    t.boolean  "estatus"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tipomedallas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false

  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

<<<<<<< HEAD
  create_table "viajes", :force => true do |t|
    t.integer  "ruta_id"
    t.string   "horainicio"
    t.string   "fecha"
    t.integer  "estadoviaje_id"
    t.integer  "estatus"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

=======
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

>>>>>>> crud_vans
end
