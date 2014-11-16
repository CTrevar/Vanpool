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

ActiveRecord::Schema.define(:version => 20141116081805) do

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
    t.integer  "puntaje",     :default => 0
    t.integer  "nivel_id",    :default => 1
    t.integer  "user_id"
    t.float    "kilometros",  :default => 0.0
    t.string   "facebook_id"
    t.string   "openpay_id"
    t.boolean  "estatus",     :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "conductors", :force => true do |t|
    t.integer  "user_id"
    t.string   "licenciaConductor"
    t.boolean  "estatusConductor"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "configuracions", :force => true do |t|
    t.string   "nombre"
    t.string   "valor"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "descuentos", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "porcentaje"
    t.integer  "vigencia"
    t.integer  "medalla_id"
    t.boolean  "estatus"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "estadotipos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "frecuencias", :force => true do |t|
    t.boolean  "lunes"
    t.boolean  "martes"
    t.boolean  "miercoles"
    t.boolean  "jueves"
    t.boolean  "viernes"
    t.boolean  "sabado"
    t.boolean  "domingo"
    t.integer  "ruta_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "horarios", :force => true do |t|
    t.time     "hora"
    t.integer  "ruta_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "medallas", :force => true do |t|
    t.integer  "tipomedalla_id"
    t.string   "nombre"
    t.integer  "puntos"
    t.string   "imagen"
    t.boolean  "estatus",        :default => true
    t.integer  "estado",         :default => 0
    t.string   "descripcion"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "medallasmuros", :force => true do |t|
    t.integer  "cliente_id"
    t.integer  "medalla_id"
    t.boolean  "cobrado"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nivels", :force => true do |t|
    t.string   "nombre"
    t.integer  "rangomaximo"
    t.boolean  "estatus"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pais", :force => true do |t|
    t.string   "clave",      :limit => 45
    t.string   "nombre",     :limit => 100
    t.string   "divisa",     :limit => 10
    t.boolean  "estatus"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "paradas", :force => true do |t|
    t.string   "nombre",     :limit => 100
    t.float    "longitud"
    t.float    "latitud"
    t.boolean  "estatus"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "reportes", :force => true do |t|
    t.integer  "cliente_id"
    t.string   "descripcion"
    t.boolean  "estatus"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reservacions", :force => true do |t|
    t.integer  "viaje_id"
    t.integer  "cliente_id"
    t.integer  "referenciapago_id"
    t.integer  "estadotipo_id"
    t.boolean  "estatus"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "retroalimentacions", :force => true do |t|
    t.integer  "reservacion_id"
    t.integer  "retroaspecto_id"
    t.integer  "calificacion"
    t.integer  "aspecto_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "retroaspectos", :force => true do |t|
    t.string   "nombre"
    t.boolean  "estatus"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rutaparadas", :force => true do |t|
    t.integer  "posicion"
    t.float    "tiempo"
    t.float    "distancia"
    t.integer  "ruta_id"
    t.integer  "parada_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rutas", :force => true do |t|
    t.integer  "conductor_id"
    t.integer  "van_id"
    t.string   "nombre"
    t.decimal  "precio"
    t.boolean  "estatus"
    t.integer  "zona_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sugerenciaparadas", :force => true do |t|
    t.decimal  "latitud"
    t.decimal  "longitud"
    t.integer  "posicion"
    t.integer  "sugerencia_id"
    t.string   "nombre"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "sugerencias", :force => true do |t|
    t.string   "hora_inicio"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tipomedallas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "idTipoUsuario"
    t.string   "apellidoPaterno"
    t.string   "apellidoMaterno"
    t.datetime "fechaNacimiento"
    t.boolean  "estatusUsuario"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

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

  create_table "viajes", :force => true do |t|
    t.integer  "ruta_id"
    t.datetime "horainicio"
    t.datetime "fecha"
    t.integer  "estadoviaje_id"
    t.integer  "estatus"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

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
