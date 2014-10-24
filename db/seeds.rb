# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# tipomedallas = Tipomedalla.create([{ nombre: 'Social' }, { nombre: 'Retro' }])
# niveles = Nivel.create([{ nombre: 'Novato 1', rangomaximo:5000 }, { nombre: 'Novato 2', rangomaximo:15000 }, { nombre: 'Novato 3', rangomaximo:25000 }])
# medallasmuros = Medallasmuro.create([{ cliente_id:1, medalla_id:1 }, { cliente_id:1, medalla_id:2 }, { cliente_id:1, medalla_id:5 }])
# estadotipos = Estadotipo.create([{ nombre:'Pendiente'},{ nombre:'Pagado'},{ nombre:'Realizado'},{ nombre:'Cancelado'}])

#estadotiposviaje = Estadotipo.create([{ nombre:'Pendiente'},{ nombre:'Iniciado'},{ nombre:'Finalizado'},{ nombre:'Cancelado'}])
#reservaciones = Reservacion.create([{viaje_id:1,cliente_id:2,referenciapago_id:3456789,estadotipo_id:1,estatus:true},
#	{viaje_id:1,cliente_id:2,referenciapago_id:3456789,estadotipo_id:2,estatus:true},
#	{viaje_id:2,cliente_id:2,referenciapago_id:34887879,estadotipo_id:2,estatus:true},
#	{viaje_id:2,cliente_id:2,referenciapago_id:348732389,estadotipo_id:2,estatus:true}])

#vans2 = Van.create([{placa:"XD-345",modelo:"Ducato",capacidad:15,co2gxkm:245, pais_id:1,fechacompra:"19/02/2004"},
#	{placa:"XD-344",modelo:"Ducato",capacidad:15,co2gxkm:245, pais_id:1,fechacompra:"19/02/2004"},
#	{placa:"XD-343",modelo:"Ducato",capacidad:15,co2gxkm:245, pais_id:1,fechacompra:"19/02/2004"}])
#retroaspectos=Retroaspecto.create([{nombre:"Limpieza de la van", estatus:true},{nombre:"Trato de conductor",estatus:true},
#	{nombre:"Comodidad de la van",estatus:true}])

#configuraciones = Configuracion.create([{ nombre: 'CO2gxkmauto', valor: 196 }, {nombre: 'impuesto', valor: 16}, {nombre: 'radio', valor: 1}])


#vans = Van.create([{placa:'SPN4735', modelo: 'Impala', capacidad:10, activa: true, estatus: true, pais_id: 1},{placa: 'KJM212K', modelo: 'Cortina', capacidad: 13, activa: true, estatus: true, pais_id: 1}, {placa: 'outatime', modelo: 'Delorean', capacidad: 15, activa: true, estatus: true, pais_id: 1}, {placa: 'CAP12T', modelo: 'Tardis', capacidad: 10, activa: true, estatus: true, pais_id: 1} ] )

# rutas = Ruta.create([{van_id:1,conductor_id:1,gmaps:3456789,kilometros:15, nombre:"Valle-Galerias",precio:20.00},
# 	{van_id:3,conductor_id:3,gmaps:3456789,kilometros:20, nombre:"Centro-Cumbres",precio:30.00},
# 	{van_id:2,conductor_id:2,gmaps:3456789,kilometros:25, nombre:"Country-Valle",precio:50.00}])

#paises = Pais.create({clave:'MX', nombre:'Mexico', divisa: 'MXN', estatus: true},{clave:'CL', nombre:'Chile', divisa: 'CLP', estatus: true})

#frecuencias = Frecuencia.create([{lunes: true, martes: false, miercoles: false, jueves:false, viernes: false, sabado: false, domingo: false, ruta_id: 1}])
#paradas = Parada.create([{nombre: "Durango 110 A, Los TreviNo", longitud: -100.4366063, latitud: 25.67093},{nombre: "Rio Danubio 325, Del Valle", longitud: -100.3793322, latitud: 25.67093}])
#rutaparadas= Rutaparada.create([{posicion: 0, tiempo: 0, distancia:0, ruta_id: 1, parada_id: 1},{posicion: 1, tiempo: 381, distancia: 2619, ruta_id:1, parada_id:2}])


# viajes = Viaje.create([{ruta_id:1,horainicio:"30/09/2014",estadoviaje_id:1,estatus:1},
# 	{ruta_id:1,horainicio:13,fecha:"29/09/2014", estadoviaje_id:1,estatus:1},
# 	{ruta_id:2,horainicio:9,fecha:"28/09/2014", estadoviaje_id:1,estatus:1},
# 	{ruta_id:2,horainicio:15,fecha:"26/09/2014", estadoviaje_id:1,estatus:1}])

#zonas = Zona.create([{clave: "CHmx", nombre: "Chapultepec", ciudad_id: 1, estauts: true}, {clave: "PLmx", nombre: "Polanco", ciudad_id: 1, estauts: true}, {clave: "SFmx", nombre: "Santa Fe", ciudad_id: 1, estauts: true}, {clave: "PSmx", nombre: "Periferico Sur", ciudad_id: 1, estauts: true}])
