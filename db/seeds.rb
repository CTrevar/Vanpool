# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tipomedallas = Tipomedalla.create([{ nombre: 'Viaje' }, { name: 'Social' }, { name: 'Retro' }])
niveles = Nivel.create([{ nombre: 'Novato 1', rangomaximo:5000 }, { nombre: 'Novato 2', rangomaximo:15000 }, { nombre: 'Novato 3', rangomaximo:25000 }])
medallasmuros = Medallasmuro.create([{ cliente_id:1, medalla_id:1 }, { cliente_id:1, medalla_id:2 }, { cliente_id:1, medalla_id:5 }])
estadotipos = Estadotipo.create([{ nombre:'Pendiente'},{ nombre:'Pagado'},{ nombre:'Realizado'},{ nombre:'Cancelado'})
reservaciones = Reservacion.create([{viaje_id:9,cliente_id:1,referenciapago_id:3456789,estadotipo_id:1,estatus:true},
	{viaje_id:1,cliente_id:1,referenciapago_id:3456789,estadotipo_id:2,estatus:true},
	{viaje_id:3,cliente_id:1,referenciapago_id:34887879,estadotipo_id:2,estatus:true},
	{viaje_id:8,cliente_id:1,referenciapago_id:348732389,estadotipo_id:2,estatus:true}])

