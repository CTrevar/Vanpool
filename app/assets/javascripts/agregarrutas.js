var map;
var arregloMarcadores = [];
var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var dir;

var currentLat;
var currentLng;
var contador = 0;
var autocomplete = [];
//variables para el autocompletado
var placeSearch, autocompleteOrigen, autocompleteDestino;

function obtenerLocalizacion() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(mostrarPosicion);
    } else { 
        //x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function mostrarPosicion(position) {
  currentLat = position.coords.latitude;
  currentLng = position.coords.longitude;
  
  //al obtener la localización, centra el mapa en donde estés
  map.setZoom(14);
  map.setCenter(new google.maps.LatLng(currentLat, currentLng));
}

function initialize() {


  obtenerLocalizacion();

  if(currentLat){
    //set up del mapa, zoom, centro
      var mapOptions = {
        zoom: 30,
        center: new google.maps.LatLng(currentLat, currentLng)
      };

  } else {
    //set up del mapa, zoom, centro
    var mapOptions = {
      zoom: 14,
      center: new google.maps.LatLng(19.4329459, -99.1384108)
    };
  }
  
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  var lineSymbol = {  
    path: google.maps.SymbolPath.FORWARD_OPEN_ARROW   
  };

  var rendererOptions = { 
    map: map,
    draggable: true,
    polylineOptions: {  
      strokeWeight: 6,  
      strokeOpacity: 0.8,   
      strokeColor: '#D84743',   
      icons: [{   
        icon: lineSymbol,   
        offset: '25%'   
        }, {icon: lineSymbol,   
        offset: '75%'   
      }]  
    }
  };

  directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);

  google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {   
      agregarArrayMarcador(directionsDisplay.getDirections().routes[0]);  
      desplegarParadas(directionsDisplay.getDirections().routes[0]);  
  });

  //Poner un marcador en el mapa cuando dé clic
  google.maps.event.addListener(map, "click", function(event)
      {
            agregarMarcador(event.latLng, 42);
          
      });


  paisRestriccion = { 'country': 'mx' };
  //AUTOCOMPLETADO
  // Create the autocomplete object, restricting the search
  // to geographical location types.
  
  for (i= 0;i<10; i++){
    autocomplete[i] = new google.maps.places.Autocomplete(
        /** @type {HTMLInputElement} */(document.getElementById('nombreParada_'+i)), {
                  componentRestrictions: paisRestriccion
        }
        );
  }
    // When the user selects an address from the dropdown,
    // populate the address fields in the form.
    
        google.maps.event.addListener(autocomplete[0], 'place_changed', function() {
            llenarDireccionAutocomplete(0);
        });

        google.maps.event.addListener(autocomplete[1], 'place_changed', function() {
            llenarDireccionAutocomplete(1);
        });

        google.maps.event.addListener(autocomplete[2], 'place_changed', function() {
            llenarDireccionAutocomplete(2);
        });
        
        google.maps.event.addListener(autocomplete[3], 'place_changed', function() {
            llenarDireccionAutocomplete(3);
        });

        google.maps.event.addListener(autocomplete[4], 'place_changed', function() {
            llenarDireccionAutocomplete(4);
        });

        google.maps.event.addListener(autocomplete[5], 'place_changed', function() {
            llenarDireccionAutocomplete(5);
        });

        google.maps.event.addListener(autocomplete[6], 'place_changed', function() {
            llenarDireccionAutocomplete(6);
        });
        
        google.maps.event.addListener(autocomplete[7], 'place_changed', function() {
            llenarDireccionAutocomplete(7);
        });

        google.maps.event.addListener(autocomplete[8], 'place_changed', function() {
            llenarDireccionAutocomplete(8);
        });

        google.maps.event.addListener(autocomplete[9], 'place_changed', function() {
            llenarDireccionAutocomplete(9);
        });
  
    



}

google.maps.event.addDomListener(window, 'load', initialize);

function agregarMarcador(location, posicion) {
    
      //agregar marcador en el mapa con posibilidad de ser movido de lugar  +
      var marker = new google.maps.Marker({   
        position: location,   
        map: map,   
        draggable: true   
      });

      // agregar el marcador al arreglo de marcadores   
      if (posicion == 42){
        arregloMarcadores.push(marker);
      } else {
        arregloMarcadores [posicion] = marker;
      }

      //obtener dirección del marcador
      obtenerDireccion(marker);

      //cuando mueva un marcador, se mueva en el mapa y se muestre dirección y latlong en pantalla
      google.maps.event.addListener(marker, 'dragend', function(event) {
        var pos = arregloMarcadores.indexOf(marker);
        arregloMarcadores[pos] = marker;
        obtenerDireccion(marker);
      });

      //cuando de clic a un marcador, se muestra dirección y latlong en pantalla y una ventana con su dirección
      google.maps.event.addListener(marker, 'click', function(event) {
         obtenerDireccion(marker);
         infowindow.setContent(dir);
         infowindow.open(map, this);
      });
      

      //si es del segundo marcador en adelante, trazar ruta
      if(arregloMarcadores.length>=2){
        trazarRuta();
        $('#letras_'+arregloMarcadores.length).show();
        $('#nombreParada_'+arregloMarcadores.length).show();
        //posicionFinal = arregloMarcadores.length-1;
        //longit = (arregloMarcadores[0].getPosition().lng()+arregloMarcadores[posicionFinal].getPosition().lng())/2;
        //latit= (arregloMarcadores[0].getPosition().lat()+arregloMarcadores[posicionFinal].getPosition().lat())/2;
        // map.setCenter({lat: latit, lng: longit});
        
      } else if (arregloMarcadores.length==1) {
        obtenerDireccion(arregloMarcadores[0]);
        map.setCenter({lat: arregloMarcadores[0].getPosition().lat(), lng: arregloMarcadores[0].getPosition().lng()});
      }
      contador+=1;
        
  }

  // Deletes all markers in the array by removing references to them
  function borrarMarcadores() {
      if (arregloMarcadores) {
          for (i in arregloMarcadores) {
              arregloMarcadores[i].setMap(null);
          }
      //arregloMarcadores.length = 0;
      }
  }

 


  function obtenerDireccion(marker){
    geocoder.geocode({'latLng': marker.getPosition()}, function(results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                  if (results[0]) {
                    dir= results[0].formatted_address;
                    
                    desplegarDireccion(dir, marker);
                      //document.getElementById("origenRuta").value = dir;
                  }
              }
      });

  }

  function desplegarDireccion(dir, marker){
    var pos = arregloMarcadores.indexOf(marker);
    //despliega la dirección del marcador en sus respectivos campos
  
      document.getElementById("nombreParada_"+pos).value = dir;
      document.getElementById("latitudParada_"+pos).value = marker.getPosition().lat();
       document.getElementById("longitudParada_"+pos).value = marker.getPosition().lng();



    // if(arregloMarcadores.length == 1) {
          
    //     } else if (arregloMarcadores.length == 2){
          
    //     }
    
  }

function desplegarParadas(routeDrawn){
        for (var posicion = 0; posicion < routeDrawn.legs.length; posicion++) {
          
          document.getElementById("nombreParada_"+posicion).value = routeDrawn.legs[posicion].start_address;
          document.getElementById("latitudParada_"+posicion).value = routeDrawn.legs[posicion].start_location.lat();
          document.getElementById("longitudParada_"+posicion).value = routeDrawn.legs[posicion].start_location.lng();
          document.getElementById("posicionParada_"+posicion).value = posicion;
          
          if(posicion == 0){
            document.getElementById("tiempoParada_"+posicion).value = 0;
            document.getElementById("distanciaParada_"+posicion).value =  0;

          } else {
            document.getElementById("tiempoParada_"+posicion).value = routeDrawn.legs[posicion-1].duration.value;
            document.getElementById("distanciaParada_"+posicion).value =  routeDrawn.legs[posicion-1].distance.value;
          }

          
          
        }

        largo = routeDrawn.legs.length;
          posicionFinal = largo-1;
        
          document.getElementById("nombreParada_"+largo).value = routeDrawn.legs[posicionFinal].end_address;
          document.getElementById("latitudParada_"+largo).value = routeDrawn.legs[posicionFinal].end_location.lat();
          document.getElementById("longitudParada_"+largo).value = routeDrawn.legs[posicionFinal].end_location.lng();
          document.getElementById("posicionParada_"+largo).value = largo;
          document.getElementById("tiempoParada_"+largo).value = routeDrawn.legs[posicionFinal].duration.value;
          document.getElementById("distanciaParada_"+largo).value =  routeDrawn.legs[posicionFinal].distance.value;

 

  }

  //AUTOCOMPLETADO



function llenarDireccionAutocomplete(posicion){
    //obtener dirección de input
      //var address = document.getElementById("origenRuta").value;
      var address = autocomplete[posicion].getPlace();
    

    //con esta dirección, obtener la localización
  /*  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var lugar = results[0].geometry.location;
      //agregar el marcador
      agregarMarcador(lugar);
    } else {
      alert('Geocode falló por: ' + status);
    }
  });*/
  
    agregarMarcador(address.geometry.location, posicion);


  }


  function agregarArrayMarcador(routeDrawn){
    arregloMarcadores[0].position = routeDrawn.legs[0].start_location;
    arregloMarcadores[1].position = routeDrawn.legs[0].end_location;

  }

  function trazarRuta(){
    var origen = arregloMarcadores[0].position;
        var destino = arregloMarcadores[arregloMarcadores.length-1].position;
        var arregloParadas=[];

        if(arregloMarcadores.length>2){

          for(i= 1; i<arregloMarcadores.length-1;i++){
            var posicionParada = arregloMarcadores[i].position;
            arregloParadas.push({
                              location: posicionParada,
                              stopover: true
                            });
            
          }

        }

        //optimize waypoints for admin false, for client will be true
        var request = {
          origin: origen,
          destination: destino,
          waypoints: arregloParadas,
          travelMode: google.maps.DirectionsTravelMode.DRIVING,
          unitSystem: google.maps.UnitSystem.METRIC,
          optimizeWaypoints: false
        }

        directionsService = new google.maps.DirectionsService();
        var rutaa= directionsService.route(request, function(response, status) {
          if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
            var routeDrawn = response.routes[0];
            //guardarParadas(routeDrawn);
            desplegarParadas(routeDrawn);
                 

                               //document.getElementById("destinoRuta").value = response.routes[0].legs[0].distance.text;
            //document.getElementById("origenRuta").value = response.routes[0].legs[0].distance.value;
          }
          else
            alert ('no se pudo obtener direcciones');
        });

        
        borrarMarcadores();
        

  }