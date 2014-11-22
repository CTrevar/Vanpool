
#encoding: utf-8 

User.create!([
  #{name: "admin", email: "admin@gmail.com", password:"1234567878", password_confirmation:"1234567878", admin: true, provider: nil, uid: nil},
  #{name: "Pedro Torres", email: "ptorres@gmail.com", password:"1234567878", password_confirmation:"1234567878", admin: false, provider: nil, uid: nil},
  # Clientes
  {name: "Chip Torres",         email: "cliente1@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "River Clark",         email: "cliente2@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Marta Jiménez",       email: "cliente3@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Elsa Laura",          email: "cliente4@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Cirstina Contreras",  email: "cliente5@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Alvaro Ponce",        email: "cliente6@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Evelin Treviño",      email: "cliente7@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "José Treviño",        email: "cliente8@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Aracely Contreras",   email: "cliente9@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Lorena Castillo",     email: "cliente10@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Laura Castillo",      email: "cliente11@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Ammy Pond",           email: "cliente12@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  {name: "Pedro Capaldi",       email: "cliente13@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-07-29 00:00:00", estatusUsuario: true},
  # Conductores
  {name: "Matt Smith",          email: "conductor1@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "David Teniente",      email: "conductor2@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Olivia Benson",       email: "conductor3@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Javier Hernandez",    email: "conductor4@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "César Esquivel",      email: "conductor5@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Gerardo Páez",        email: "conductor6@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Eduardo Cano",        email: "conductor7@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Ángel Esparza",       email: "conductor8@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Ángel Benson",        email: "conductor9@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Juan Profundo",       email: "conductor10@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Scarlata Johansen",   email: "conductor11@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Crisóforo Liahut",    email: "conductor12@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  {name: "Alejandro Atzin",     email: "conductor13@gmail.com", password:'12345678', password_confirmation:'12345678', admin: false,  fechaNacimiento: "1992-03-09 00:00:00", estatusUsuario: true},
  # Administradores
  {name: "Meredith Grey",       email: "admin1@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Gregorio Casas",      email: "admin2@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Andrés Garfield",     email: "admin3@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Jorge Arbustos",      email: "admin4@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Benedicto Flores",    email: "admin5@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Elizabeth Kahwti",    email: "admin6@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Consuelo del Río",    email: "admin7@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Antonio Santino",     email: "admin8@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Santino Vela",        email: "admin9@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Emilio Carrazco",     email: "admin10@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Marco Huerta",        email: "admin11@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Samuel Cardona",      email: "admin12@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true},
  {name: "Maritere Salinas",    email: "admin13@gmail.com", password:'12345678', password_confirmation:'12345678', admin: true,  fechaNacimiento: "1992-12-25 00:00:00", estatusUsuario: true}
])

Conductor.create!([ {user_id:15,licenciaConductor:"SVG6404",estatusConductor:true},
                    {user_id:16,licenciaConductor:"SVG5475",estatusConductor:true},
                    {user_id:17,licenciaConductor:"SVG1527",estatusConductor:true},
                    {user_id:18,licenciaConductor:"SVG1888",estatusConductor:true},
                    {user_id:19,licenciaConductor:"SVG5189",estatusConductor:true},
                    {user_id:20,licenciaConductor:"ATV7495",estatusConductor:true},
                    {user_id:21,licenciaConductor:"ATV7596",estatusConductor:true},
                    {user_id:22,licenciaConductor:"ATV3256",estatusConductor:true},
                    {user_id:23,licenciaConductor:"ATV8486",estatusConductor:true},
                    {user_id:24,licenciaConductor:"ATV9945",estatusConductor:true},
                    {user_id:25,licenciaConductor:"MRN6509",estatusConductor:true},
                    {user_id:26,licenciaConductor:"MRN2597",estatusConductor:true}
])

Van.create!([
 {placa: "SPN4735", modelo: "Impala", capacidad: 10, fecha_compra: "2011-04-06", kilometro_recorrido: 0, activa: true, estatus: true, pais_id: 1}
])

Medalla.create!([
  {tipomedalla_id: 1, nombre: "Primer viaje", puntos: 5000, imagen: "viaje1.png", estatus: true, estado: 1, descripcion: nil},
  {tipomedalla_id: 1, nombre: "Quinto Viaje", puntos: 5000, imagen: "viaje5.png", estatus: true, estado: 5, descripcion: nil},
  {tipomedalla_id: 2, nombre: "Evangelista (500 shares)", puntos: 500, imagen: "share500.jpg", estatus: true, estado: 500, descripcion: nil},
  {tipomedalla_id: 2, nombre: "Socialite (100 shares)", puntos: 500, imagen: "share100.jpg", estatus: true, estado: 100, descripcion: nil},
  {tipomedalla_id: 2, nombre: "Vocero (25 shares)", puntos: 500, imagen: "share25.jpg", estatus: true, estado: 0, descripcion: nil},
  {tipomedalla_id: 3, nombre: "Primer retro", puntos: 500, imagen: "retro1.png", estatus: true, estado: 0, descripcion: nil},
  {tipomedalla_id: 3, nombre: "Quinta retro", puntos: 500, imagen: "retro5.png", estatus: true, estado: 0, descripcion: nil},
  {tipomedalla_id: 1, nombre: "Decimo viaje", puntos: 10000, imagen: "viaje10.jpg", estatus: true, estado: 10, descripcion: nil},
  {tipomedalla_id: 4, nombre: "soldout1", puntos: 5000, imagen: "agotado1.png", estatus: true, estado: 1, descripcion: nil},
  {tipomedalla_id: 4, nombre: "soldout2", puntos: 5000, imagen: "agotado5.png", estatus: true, estado: 5, descripcion: nil}
])
Nivel.create!([
    {nombre: "Novato 1", rangomaximo: 4999, estatus: true},
    {nombre: "Novato 2", rangomaximo: 24999, estatus: true},
    {nombre: "Aprendiz 1", rangomaximo: 49999, estatus: true},
    {nombre: "Aprendiz 2", rangomaximo: 74999, estatus: true},
    {nombre: "Aprendiz 2", rangomaximo: 99999, estatus: true},
    {nombre: "Aprendiz 3", rangomaximo: 124999, estatus: true},
    {nombre: "Experto 1", rangomaximo: 174999, estatus: true},
    {nombre: "Experto 2", rangomaximo: 224999, estatus: true},
    {nombre: "Veterano 1", rangomaximo: 299999, estatus: true},
    {nombre: "Veterano 2", rangomaximo: 374999, estatus: true},
    {nombre: "Veterano 3", rangomaximo: 499999, estatus: true},
    {nombre: "Gurú", rangomaximo: 999999, estatus: true}
  ])


Parada.create!([
  {nombre: "Durango 110A, Los Treviño, 66376 Nuevo Leon, Mexico", longitud: -100.4366063, latitud: 25.67093, estatus: true},
  {nombre: "Lic. Gustavo Díaz Ordaz 100-S, Sin Nombre de Colonia 27, Monterrey, Nuevo Leon, Mexico", longitud: -100.3793322, latitud: 25.67093, estatus: true},
  {nombre: "Del Encino 104, Lomas del Rosario, 66287 Nuevo Leon, Mexico", longitud: -100.39546419999999, latitud: 25.6412933, estatus: nil},
  {nombre: "Carrizalejo 105, Zona Carrizalejo, 66254 Nuevo Leon, Mexico", longitud: -100.36499709999998, latitud: 25.6387654, estatus: nil},
  {nombre: "Cuauhtémoc 145, Residencial Cuauhtémoc, 66360 Nuevo Leon, Mexico", longitud: -100.44163020000002, latitud: 25.6825928, estatus: nil},
  {nombre: "La Gloria 109, Hacienda El Rosario, 66247 Nuevo Leon, Mexico", longitud: -100.38654070000001, latitud: 25.6501053, estatus: nil},
  {nombre: "Lourdes 5, Hacienda El Rosario, 66247 Nuevo Leon, Mexico", longitud: -100.39033240000003, latitud: 25.6445404, estatus: nil},
  {nombre: "Hoyo 6 104, Jardines del Campestre, 66260 San Pedro Garza García, Nuevo Leon, Mexico", longitud: -100.344336, latitud: 25.6490095, estatus: nil},
  {nombre: "Manuel Doblado 414-420, Casco Urbano, 66230 Nuevo Leon, Mexico", longitud: -100.39321840000002, latitud: 25.6557306, estatus: nil},
  {nombre: "Hacienda de San Francisco, Sin Nombre de Colonia 32, Monterrey, Nuevo Leon, Mexico", longitud: -100.34946909999996, latitud: 25.6645464, estatus: nil},
  {nombre: "Avenida Alfonso Reyes 1358, Jardines Coloniales 1er Sector, 66230 Nuevo Leon, Mexico", longitud: -100.39689629999998, latitud: 25.6528038, estatus: nil},
  {nombre: "Eje Metropolitano 7 213, Del Valle, 66220 Nuevo Leon, Mexico", longitud: -100.3689728, latitud: 25.6603322, estatus: nil},
  {nombre: "Barcelona 103, Rincón de San Jerónimo, 64635 Monterrey, Nuevo Leon, Mexico", longitud: -100.3771668, latitud: 25.6885415, estatus: nil},
  {nombre: "Av. Olinca, Nuevo Leon, Mexico", longitud: -100.43204760000003, latitud: 25.6532514, estatus: nil},
  {nombre: "Isaac Garza 1112, Casco Urbano, 66230 Nuevo Leon, Mexico", longitud: -100.39531729999999, latitud: 25.657419, estatus: nil},
  {nombre: "Miguel Hidalgo y Costilla 701-761, La Fama, 66100 Nuevo Leon, Mexico", longitud: -100.43082900000002, latitud: 25.6676718, estatus: nil},
  {nombre: "Paseo de Los Leones, Cima del Bosque, 64344 Monterrey, Nuevo Leon, Mexico", longitud: -100.40375589999996, latitud: 25.7359418, estatus: nil},
  {nombre: "Tolteca 7303, Unidad Modelo, 64140 Monterrey, Nuevo Leon, Mexico", longitud: -100.35448129999997, latitud: 25.7401879, estatus: nil},
  {nombre: "Calle de los zenzontles 123, San Jerónimo 1o. Sector, Monterrey, Nuevo Leon, Mexico", longitud: -100.36505970000002, latitud: 25.6811278, estatus: nil},
  {nombre: "Avenida Francisco I. Madero 2201, Mitras Sur, 64000 Monterrey, Nuevo Leon, Mexico", longitud: -100.33350410000003, latitud: 25.6862131, estatus: nil},
  {nombre: "Boulevard Gustavo Díaz Ordaz, El Lechugal, 66376 Nuevo Leon, Mexico", longitud: -100.43782980000003, latitud: 25.6745601, estatus: nil},
  {nombre: "Eje Metropolitano 410, Sin Nombre de Colonia 27, Monterrey, Nuevo Leon, Mexico", longitud: -100.3773645, latitud: 25.6804894, estatus: nil},
  {nombre: "De Los Colibríes 516, San Jerónimo 2o. Sector, 64634 Monterrey, Nuevo Leon, Mexico", longitud: -100.3697429, latitud: 25.6826109, estatus: nil},
  {nombre: "Potrero Chico 301, Hacienda Los Portales, 66120 Nuevo Leon, Mexico", longitud: -100.43614919999999, latitud: 25.6809919, estatus: nil},
  {nombre: "R. de Las Mitras 212, Rincón de Corregidora, 66239 Nuevo Leon, Mexico", longitud: -100.40331379999998, latitud: 25.668548, estatus: nil}
])
Reservacion.create!([
  {viaje_id: 1, cliente_id: 2, referenciapago_id: nil, estadotipo_id: 1, estatus: true},
  {viaje_id: 1, cliente_id: 1, referenciapago_id: 3456789, estadotipo_id: 2, estatus: true},
  {viaje_id: 2, cliente_id: 2, referenciapago_id: nil, estadotipo_id: 1, estatus: true},
  {viaje_id: 2, cliente_id: 1, referenciapago_id: 348732389, estadotipo_id: 3, estatus: true}
])
Retroaspecto.create!([
  {nombre: "Limpieza de la van", estatus: true},
  {nombre: "Trato de conductor", estatus: true},
  {nombre: "Comodidad de la van", estatus: true}
])
Ruta.create!([
  {conductor_id: 1, van_id: 1, nombre: "Valle-Galerias", precio: "20.0", estatus: true, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "Centro-Cumbres", precio: "30.0", estatus: false, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "Country-Valle", precio: "50.0", estatus: false, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "newerkjh", precio: "322.0", estatus: false, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "newerkjh", precio: "312.0", estatus: false, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "nomnew", precio: "32.0", estatus: true, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "nomnew", precio: "32.0", estatus: false, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "nomnew", precio: "32.0", estatus: false, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "nomnew", precio: "32.0", estatus: false, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "Gallifrey-Kashyyyk", precio: "420.0", estatus: true, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "Corellia-Coruscant", precio: "322.0", estatus: true, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "Nal Hutta - Naboo", precio: "32.0", estatus: true, zona_id: nil},
  {conductor_id: 1, van_id: 1, nombre: "P4X639 - Abydos", precio: "322.0", estatus: true, zona_id: 1},
  {conductor_id: 1, van_id: 1, nombre: "Chulak-Asgard", precio: "322.0", estatus: true, zona_id: 1},
  {conductor_id: 1, van_id: 1, nombre: "Hermes - Kronos", precio: "322.0", estatus: true, zona_id: 1},
  {conductor_id: 1, van_id: 1, nombre: "Lantea - Novus", precio: "120.0", estatus: true, zona_id: 1},
  {conductor_id: 1, van_id: 1, nombre: "Sateda - Athos", precio: "123.0", estatus: true, zona_id: 3},
  {conductor_id: 1, van_id: 1, nombre: "Dagan - Asuras", precio: "123.0", estatus: true, zona_id: 8},
  {conductor_id: 1, van_id: 1, nombre: "Jenev - Vedeena", precio: "123.0", estatus: true, zona_id: 10}
])
Sugerencia.create!([
  {hora_inicio: "2014-10-22 17:25:33.338532"},
  {hora_inicio: "2014-10-20 11:20:00.000000"},
  {hora_inicio: "2014-10-20 19:15:00.000000"},
  {hora_inicio: "2014-10-21 17:40:00.000000"},
  {hora_inicio: "2014-10-22 04:45:00.000000"},
  {hora_inicio: "2014-10-21 16:45:00.000000"},
  {hora_inicio: "2014-10-22 02:45:00.000000"},
  {hora_inicio: "2014-10-22 20:45:00.000000"},
  {hora_inicio: "2014-10-22 20:45:00.000000"},
  {hora_inicio: "2014-10-22 21:45:00.000000"},
  {hora_inicio: "2014-10-22 22:15:00.000000"},
  {hora_inicio: "2014-10-22 22:00:00.000000"},
  {hora_inicio: "2014-10-22 22:00:00.000000"},
  {hora_inicio: "2014-10-23 20:30:00.000000"},
  {hora_inicio: "2014-10-23 23:15:00.000000"},
  {hora_inicio: "2014-10-27 19:15:00.000000"},
  {hora_inicio: "2014-10-27 19:15:00.000000"},
  {hora_inicio: "2014-10-27 19:15:00.000000"},
  {hora_inicio: "2014-10-29 19:00:00.000000"},
  {hora_inicio: "2014-11-08 08:30:00.000000"},
  {hora_inicio: "2014-11-08 08:30:00.000000"},
  {hora_inicio: "2014-11-08 08:30:00.000000"}
])
Tipomedalla.create!([
  {nombre: "Viaje"},
  {nombre: "Social"},
  {nombre: "Retro"},
  {nombre: "SoldOut"},
  {nombre: "BDay"},
  {nombre: "Continuidad"},
  {nombre: "Con amigos"},
  {nombre: "Host"},
  {nombre: "Nivel"}
])
Van.create!([
  {placa: "SPN4735", modelo: "Impala", capacidad: 10,  fecha_compra: "2011-04-06", kilometro_recorrido: nil, activa: true, estatus: true, pais_id: 1},
  {placa: "KJM212K", modelo: "Cortina", capacidad: 13, fecha_compra: "2013-03-03", kilometro_recorrido: nil, activa: true, estatus: true, pais_id: 1},
  {placa: "OUTATIME", modelo: "DeLorean", capacidad: 15,  fecha_compra: "2012-04-02", kilometro_recorrido: nil, activa: true, estatus: true, pais_id: 1},
  {placa: "TRD12G", modelo: "TARDIS", capacidad: 11,  fecha_compra: "2014-03-10", kilometro_recorrido: nil, activa: true, estatus: true, pais_id: 1},
  {placa: "3467LUCY", modelo: "Cutlass", capacidad: 12,  fecha_compra: "2011-04-03", kilometro_recorrido: nil, activa: true, estatus: true, pais_id: 1}
])
Viaje.create!([
  {ruta_id: 1, horainicio: "2000-01-01 12:30:00", fecha: "2014-09-27 05:00:00", estadoviaje_id: 1, estatus: 1},
  {ruta_id: 2, horainicio: "2000-01-01 13:15:00", fecha: "2014-10-27 00:26:53", estadoviaje_id: 1, estatus: 1},
  {ruta_id: 3, horainicio: "2000-01-01 12:30:00", fecha: "2014-11-01 00:28:14", estadoviaje_id: 1, estatus: 1},
  {ruta_id: 4, horainicio: "2000-01-01 12:30:00", fecha: "2014-10-22 23:27:50", estadoviaje_id: 1, estatus: 1},
  {ruta_id: 5, horainicio: "2000-01-01 12:30:00", fecha: "2014-10-19 23:28:44", estadoviaje_id: 1, estatus: 1},
  {ruta_id: 6, horainicio: "2000-01-01 20:00:00", fecha: "2014-11-25 00:29:40", estadoviaje_id: 1, estatus: 1},
  {ruta_id: 7, horainicio: "2000-01-01 02:45:00", fecha: "2014-11-25 00:29:59", estadoviaje_id: 1, estatus: 1},
  {ruta_id: 7, horainicio: "2000-01-01 02:45:00", fecha: "2014-11-25 00:30:07", estadoviaje_id: 1, estatus: 1}
])
Ciudad.create!([
  {clave: "DF", nombre: "Ciudad de Mexico", estauts: true, pais_id: 1}
])
Configuracion.create!([
  {nombre: "CO2gxkmauto", valor: "180"},
  {nombre: "impuesto", valor: "16"},
  {nombre: "radio", valor: "1"},
  {nombre: "modeloauto", valor: "Tsuru 2015"},
  {nombre: "fuenteCO2", valor: "http://www.ecovehiculos.gob.mx/ecoetiquetado.php?vehiculo_id=14177"},
  {nombre: "correoBienvenida", valor: "<p><img alt=\"Vanpool\" src=\"http://www.vanpool.mx/uploads/1/2/6/7/12675191/1390415955.png\" style=\"height:38px; width:110px\" /></p>\r\n\r\n<hr />\r\n<h1>Hola&nbsp;<strong>@usuario</strong>!</h1>\r\n\r\n<h2>Te est&aacute; llegando este correo porque te acabas&nbsp;de registrar en Vanpool.</h2>\r\n\r\n<h2>Recuerda que Aventones te ayuda a encontrar gente con la cual compartir autom&oacute;vil y de esta forma, solucionar el problema del tr&aacute;fico estar&aacute; en tus manos.</h2>\r\n\r\n<h2>Gracias,</h2>\r\n\r\n<h3><em>Aventones Dame Ride UDEM</em></h3>\r\n"},
  {nombre: "correoRecordatorio", valor: "<p><img alt=\"Vanpool\" src=\"http://www.vanpool.mx/uploads/1/2/6/7/12675191/1390415955.png\" style=\"height:38px; width:110px\" /></p>\r\n\r\n<hr />\r\n<h1 style=\"text-align:center\"><span style=\"font-size:48px\">&iquest;Cu&aacute;ndo vas a regresar? =(</span></h1>\r\n\r\n<p style=\"text-align:center\"><img alt=\"\" class=\"left\" src=\"http://4.bp.blogspot.com/-AOFUPvN5Fbc/UMbYptdHkEI/AAAAAAAAACM/Nng4hx3QT08/s1600/polar+bear.png\" style=\"float:right; height:240px; margin:10px; width:240px\" /></p>\r\n\r\n<div style=\"font-size: 13.3333330154419px; line-height: 27.7333316802979px; border: 1px solid rgb(204, 204, 204); padding: 5px 10px; background: rgb(238, 238, 238);\">\r\n<h2>Hola @usuario!</h2>\r\n\r\n<h3>Recuerda que cuando utilizas nuestros servicios, ayudas a ahorrar emisiones de CO2 a la atm&oacute;sfera, con lo cual, contribuyes a abatir al cambio clim&aacute;tico que exprimenta nuestro hermoso planeta.</h3>\r\n\r\n<h3>En cualquier momento puedes regresar a neustra plataforma y contribuir al cambio clim&aacute;tico utilizando&nbsp;<a href=\"http://www.vanpool.com\">nuestros servicios</a>.<br />\r\nSinceramente, esperamos que te encuentres bien y que regreses pronto a nuestra plataforma..</h3>\r\n\r\n<p><br />\r\nSaludos,</p>\r\n\r\n<h3><em>Aventones Vanpool</em></h3>\r\n</div>\r\n"},
  {nombre: "frecuenciaCorreosRecordatorios", valor: "20"}
])
Estadotipo.create!([
  {nombre: "Pendiente"},
  {nombre: "Pagado"},
  {nombre: "Realizado"},
  {nombre: "Cancelado"}
])
Frecuencia.create!([
  {lunes: true, martes: false, miercoles: false, jueves: false, viernes: false, sabado: false, ruta_id: 1, domingo: false},
  {lunes: nil, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 5, domingo: nil},
  {lunes: nil, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: nil, domingo: nil},
  {lunes: nil, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 6, domingo: nil},
  {lunes: nil, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 7, domingo: nil},
  {lunes: nil, martes: nil, miercoles: nil, jueves: nil, viernes: true, sabado: nil, ruta_id: 10, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 11, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 12, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 13, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 14, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 15, domingo: nil},
  {lunes: nil, martes: nil, miercoles: nil, jueves: true, viernes: true, sabado: true, ruta_id: 16, domingo: true},
  {lunes: nil, martes: nil, miercoles: nil, jueves: nil, viernes: true, sabado: nil, ruta_id: 17, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 18, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 19, domingo: nil},
  {lunes: true, martes: nil, miercoles: nil, jueves: nil, viernes: nil, sabado: nil, ruta_id: 20, domingo: nil}
])
Horario.create!([
  {hora: nil, ruta_id: 5},
  {hora: nil, ruta_id: nil},
  {hora: nil, ruta_id: 6},
  {hora: nil, ruta_id: 7},
  {hora: "2000-01-01 12:30:00", ruta_id: 10},
  {hora: "2000-01-01 12:30:00", ruta_id: 11},
  {hora: "2000-01-01 13:15:00", ruta_id: 12},
  {hora: "2000-01-01 12:30:00", ruta_id: 13},
  {hora: "2000-01-01 12:30:00", ruta_id: 14},
  {hora: "2000-01-01 12:30:00", ruta_id: 15},
  {hora: "2000-01-01 20:00:00", ruta_id: 16},
  {hora: "2000-01-01 02:45:00", ruta_id: 17},
  {hora: "2000-01-01 12:15:00", ruta_id: 18},
  {hora: "2000-01-01 12:30:00", ruta_id: 19},
  {hora: "2000-01-01 12:30:00", ruta_id: 20},
  {hora: "2000-01-01 13:00:00", ruta_id: 21}
])
Medallasmuro.create!([
  {cliente_id: 2, medalla_id: 1, cobrado: false},
  {cliente_id: 2, medalla_id: 2, cobrado: false},
  {cliente_id: 2, medalla_id: 10, cobrado: false},
  {cliente_id: 2, medalla_id: 10, cobrado: false},
  {cliente_id: 1, medalla_id: 2, cobrado: false},
  {cliente_id: 3, medalla_id: 1, cobrado: false},
  {cliente_id: 23, medalla_id: 1, cobrado: nil},
  {cliente_id: 23, medalla_id: 10, cobrado: nil},
  {cliente_id: 23, medalla_id: 10, cobrado: nil},
  {cliente_id: 23, medalla_id: 10, cobrado: nil},
  {cliente_id: 23, medalla_id: 10, cobrado: nil},
  {cliente_id: 23, medalla_id: 2, cobrado: nil},
  {cliente_id: 23, medalla_id: 10, cobrado: nil}
])
Pais.create!([
  {clave: "MX", nombre: "Mexico", divisa: "MXN", estatus: true},
  {clave: "CL", nombre: "Chile", divisa: "CLP", estatus: true},
  {clave: "GB", nombre: "Great Britain", divisa: "GBP", estatus: false}
])
Rutaparada.create!([
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 1, parada_id: 1},
  {posicion: 1, tiempo: 381.0, distancia: 2619.0, ruta_id: 1, parada_id: 2},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 2, parada_id: 11},
  {posicion: 1, tiempo: 506.0, distancia: 4140.0, ruta_id: 1, parada_id: 12},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 11, parada_id: 13},
  {posicion: 1, tiempo: 785.0, distancia: 9713.0, ruta_id: 11, parada_id: 14},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 12, parada_id: 15},
  {posicion: 1, tiempo: 671.0, distancia: 6895.0, ruta_id: 12, parada_id: 16},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 13, parada_id: 17},
  {posicion: 1, tiempo: 716.0, distancia: 6801.0, ruta_id: 13, parada_id: 18},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 14, parada_id: 19},
  {posicion: 1, tiempo: 421.0, distancia: 4419.0, ruta_id: 14, parada_id: 20},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 15, parada_id: 21},
  {posicion: 1, tiempo: 929.0, distancia: 11412.0, ruta_id: 15, parada_id: 22},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 16, parada_id: 23},
  {posicion: 1, tiempo: 634.0, distancia: 5717.0, ruta_id: 16, parada_id: 24},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 17, parada_id: 25},
  {posicion: 1, tiempo: 336.0, distancia: 1583.0, ruta_id: 17, parada_id: 26},
  {posicion: 1, tiempo: 442.0, distancia: 4027.0, ruta_id: 18, parada_id: 27},
  {posicion: 2, tiempo: 442.0, distancia: 4027.0, ruta_id: 18, parada_id: 28},
  {posicion: 1, tiempo: 801.0, distancia: 11898.0, ruta_id: 19, parada_id: 29},
  {posicion: 2, tiempo: 801.0, distancia: 11898.0, ruta_id: 19, parada_id: 30},
  {posicion: 0, tiempo: 0.0, distancia: 0.0, ruta_id: 20, parada_id: 31},
  {posicion: 1, tiempo: 692.0, distancia: 5459.0, ruta_id: 20, parada_id: 32},
  {posicion: 2, tiempo: 692.0, distancia: 5459.0, ruta_id: 20, parada_id: 33}
])
Sugerenciaparada.create!([
  {latitud: "25.6633183", longitud: "-100.4189359", posicion: 0, sugerencia_id: 1, nombre: "Eje Metropolitano 6, UDEM, Zona Valle Poniente, NL"},
  {latitud: "25.6526249", longitud: "-100.288725", posicion: 1, sugerencia_id: 1, nombre: "E1, Junco De La Vega, Tecnológico de Monterrey, Tecnológico"},
  {latitud: "25.6609018", longitud: "-100.3960408", posicion: 0, sugerencia_id: 2, nombre: "Gral. Porfirio Díaz 901, Casco Urbano, 66230 NL, México"},
  {latitud: "25.6634773", longitud: "-100.3524343", posicion: 1, sugerencia_id: 2, nombre: "Eje Metropolitano 9, Zona La Diana, NL, México"},
  {latitud: "25.741098", longitud: "-100.3851941", posicion: 0, sugerencia_id: 3, nombre: "Cerro del Topo 6144-6146, Valle de Las Cumbres, 1º Sector, Monterrey, NL, México"},
  {latitud: "25.7139346", longitud: "-100.3240605", posicion: 1, sugerencia_id: 3, nombre: "Francisco S. Carvajal 1025, Niño Artillero, 64280 Monterrey, NL, México"},
  {latitud: "25.6868796", longitud: "-100.4527054", posicion: 0, sugerencia_id: 4, nombre: "Onix Pte., Sin Nombre de Colonia 3, NL, México"},
  {latitud: "25.6680166", longitud: "-100.3901419", posicion: 1, sugerencia_id: 4, nombre: "San Patricio 125, Zona Los Callejones, 66230 Monterrey, NL, México"},
  {latitud: "25.6798418", longitud: "-100.4507892", posicion: 0, sugerencia_id: 5, nombre: "Carretera Federal 40 2300, Sin Nombre de Colonia 21, NL, México"},
  {latitud: "25.656448", longitud: "-100.3797096", posicion: 1, sugerencia_id: 5, nombre: "Río Rhin 310-314, Del Valle, 66220 Monterrey, NL, México"},
  {latitud: "25.6798418", longitud: "-100.4507892", posicion: 0, sugerencia_id: 6, nombre: "Carretera Federal 40 2300, Sin Nombre de Colonia 21, NL, México"},
  {latitud: "25.656448", longitud: "-100.3797096", posicion: 1, sugerencia_id: 6, nombre: "Río Rhin 310-314, Del Valle, 66220 Monterrey, NL, México"},
  {latitud: "25.6827689", longitud: "-100.4758824", posicion: 0, sugerencia_id: 7, nombre: "Dionisio de Herrera 103, Zimix, 66358 NL, México"},
  {latitud: "25.6585536", longitud: "-100.4169773", posicion: 1, sugerencia_id: 7, nombre: "Eje Metropolitano 6, Zona Valle Poniente, Monterrey, NL, México"},
  {latitud: "25.6647025", longitud: "-100.4355634", posicion: 0, sugerencia_id: 8, nombre: "Encino 105, Protexa, 66170 NL, México"},
  {latitud: "25.6555177", longitud: "-100.385198", posicion: 1, sugerencia_id: 8, nombre: "Carrizalejo 105, San Pedro Garza García, México"},
  {latitud: "25.670855", longitud: "-100.4364791", posicion: 0, sugerencia_id: 9, nombre: "Durango 110, Los Treviño, NL, México"},
  {latitud: "25.6564569", longitud: "-100.3721165", posicion: 1, sugerencia_id: 9, nombre: "Río Danubio, Del Valle, Monterrey, México"},
  {latitud: "25.670855", longitud: "-100.4364791", posicion: 0, sugerencia_id: 10, nombre: "Durango 110, Los Treviño, NL, México"},
  {latitud: "25.6564569", longitud: "-100.3721165", posicion: 1, sugerencia_id: 10, nombre: "Río Danubio, Del Valle, Monterrey, México"},
  {latitud: "25.670855", longitud: "-100.4364791", posicion: 0, sugerencia_id: 12, nombre: "Durango 110, Los Treviño, NL, México"},
  {latitud: "25.6564569", longitud: "-100.3721165", posicion: 1, sugerencia_id: 12, nombre: "Río Guayalejo 105, Del Valle, 66220 NL, México"},
  {latitud: "25.670855", longitud: "-100.4364791", posicion: 0, sugerencia_id: 13, nombre: "Durango 110, Los Treviño, NL, México"},
  {latitud: "25.6574091", longitud: "-100.3754838", posicion: 1, sugerencia_id: 13, nombre: "Río Danubio 202-210, Del Valle, 66220 Monterrey, NL, México"},
  {latitud: "25.670855", longitud: "-100.4364791", posicion: 0, sugerencia_id: 14, nombre: "Durango 110, Los Treviño, NL, México"},
  {latitud: "25.6574361", longitud: "-100.3755739", posicion: 1, sugerencia_id: 14, nombre: "Río Danubio 210, Del Valle, 66220 NL, México"},
  {latitud: "25.6633183", longitud: "-100.4189359", posicion: 0, sugerencia_id: 15, nombre: "UDEM, Eje Metropolitano 6, Zona Valle Poniente, NL, México"},
  {latitud: "25.6526249", longitud: "-100.288725", posicion: 1, sugerencia_id: 15, nombre: "Tecnológico, Monterrey, México"},
  {latitud: "25.6633183", longitud: "-100.4189359", posicion: 0, sugerencia_id: 16, nombre: "UDEM, Eje Metropolitano 6, Zona Valle Poniente, NL, México"},
  {latitud: "25.6691482", longitud: "-100.3094452", posicion: 1, sugerencia_id: 16, nombre: "Macroplaza, Monterrey, México"},
  {latitud: "25.6854807", longitud: "-100.4461477", posicion: 0, sugerencia_id: 17, nombre: "Puerto Cumarebo 206, Residencial Cuauhtémoc, 66360 NL, México"},
  {latitud: "25.6827353", longitud: "-100.3734586", posicion: 1, sugerencia_id: 17, nombre: "Camino de Los Pavorreales 521-525, San Jerónimo 4o. Sector, 64634 Monterrey, NL, México"},
  {latitud: "25.6854807", longitud: "-100.4461477", posicion: 0, sugerencia_id: 18, nombre: "Puerto Cumarebo 206, Residencial Cuauhtémoc, 66360 NL, México"},
  {latitud: "25.6827353", longitud: "-100.3734586", posicion: 1, sugerencia_id: 18, nombre: "Camino de Los Pavorreales 521-525, San Jerónimo 4o. Sector, 64634 Monterrey, NL, México"},
  {latitud: "25.6854807", longitud: "-100.4461477", posicion: 0, sugerencia_id: 19, nombre: "Puerto Cumarebo 206, Residencial Cuauhtémoc, 66360 NL, México"},
  {latitud: "25.6827353", longitud: "-100.3734586", posicion: 1, sugerencia_id: 19, nombre: "Camino de Los Pavorreales 521-525, San Jerónimo 4o. Sector, 64634 Monterrey, NL, México"},
  {latitud: "25.6445013", longitud: "-100.3471421", posicion: 0, sugerencia_id: 20, nombre: "Avenida Alfonso Reyes 107, Veredalta, NL, México"},
  {latitud: "25.6621707", longitud: "-100.4212473", posicion: 1, sugerencia_id: 20, nombre: "UDEM, Eje Metropolitano 6, Zona Valle Poniente, NL, México"},
  {latitud: "25.680141", longitud: "-100.354224", posicion: 0, sugerencia_id: 20, nombre: "General Pablo González Garza 1282-S, San Jerónimo, 64634 Monterrey, Nuevo Leon, Mexico"},
  {latitud: "25.7473609", longitud: "-100.3006184", posicion: 1, sugerencia_id: 20, nombre: "Universidad de Monterrey, Roble Norte, San Nicolás de los Garza, Mexico"},
  {latitud: "25.670855", longitud: "-100.4364791", posicion: 0, sugerencia_id: 21, nombre: "Durango 110, Los Treviño, Nuevo Leon, Mexico"},
  {latitud: "25.6296705", longitud: "-100.2889895", posicion: 1, sugerencia_id: 21, nombre: "Josefa Ortiz de Domínguez 100, Sierra Ventana (Fomerrey 77), 64780 Monterrey, Nuevo Leon, Mexico"},
  {latitud: "25.670855", longitud: "-100.4364791", posicion: 0, sugerencia_id: 22, nombre: "Durango 110, Los Treviño, Nuevo Leon, Mexico"},
  {latitud: "25.6296705", longitud: "-100.2889895", posicion: 1, sugerencia_id: 22, nombre: "Josefa Ortiz de Domínguez 100, Sierra Ventana (Fomerrey 77), 64780 Monterrey, Nuevo Leon, Mexico"}
])
Zona.create!([
  {clave: "VLmty", nombre: "Valle", estauts: true, ciudad_id: 1},
  {clave: "MTmty", nombre: "Mitras", estauts: true, ciudad_id: 1},
  {clave: "CTmty", nombre: "Centro", estauts: true, ciudad_id: 1},
  {clave: "CUmty", nombre: "Cumbres", estauts: true, ciudad_id: 1}
])
Tipocalificacion.create!([
  {nombre: "Malo"},
  {nombre: "Regular"},
  {nombre: "Bueno"},
  {nombre: "Excelente"}
])
