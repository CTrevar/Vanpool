var map;
var arregloMarcadores = [];
var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var dir;

var currentLat;
var currentLng;
var paradaId= 0;
var contador = 1;

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
  map.setCenter(new google.maps.LatLng(currentLat, currentLng));
}

function initialize() {

  obtenerLocalizacion();

  if(currentLat){
    //set up del mapa, zoom, centro
      var mapOptions = {
        zoom: 13,
        center: new google.maps.LatLng(currentLat, currentLng)
      };

  } else {
    //set up del mapa, zoom, centro
    var mapOptions = {
      zoom: 13,
      center: new google.maps.LatLng(19.4329459, -99.1384108)
    };
  }
  
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);


  var rendererOptions = { 
    map: map,
    draggable: true
  };

  directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);

  //Poner un marcador en el mapa cuando dé clic
  google.maps.event.addListener(map, "click", function(event)
      {
          // agregar un marcador
          agregarMarcador(event.latLng);

          // desplegar latitud y longitud en pantalla
          //obtenerLatLong(event);
          //obtenerDireccion();
          
      });

  google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
                //desplegarParadas(directionsDisplay.getDirections().routes[0]);
  });


}

google.maps.event.addDomListener(window, 'load', initialize);

function agregarMarcador(location) {

      //agregar marcador en el mapa con posibilidad de ser movido de lugar
      var marker = new google.maps.Marker({
          position: location, 
          map: map,
          draggable: true
      });

      // agregar el marcador al arreglo de marcadores
      arregloMarcadores.push(marker);

      //obtener dirección del marcador
      obtenerDireccion(marker);

      //cuando mueva un marcador, se mueva en el mapa y se muestre dirección y latlong en pantalla
      google.maps.event.addListener(marker, 'dragend', function(event) {
          
          obtenerDireccion(marker);
      });

      //cuando de clic a un marcador, se muestra dirección y latlong en pantalla y una ventana con su dirección
      google.maps.event.addListener(marker, 'click', function(event) {
        obtenerDireccion(marker);
        infowindow.setContent(dir);
        infowindow.open(map, this);
      });

      

        
      //si es del segundo marcador en adelante, trazar ruta
      if(arregloMarcadores.length==2){
        trazarRuta();
      }//(if) más de 2 marcadores



        
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
            
          }
          else
            alert ('no se pudo obtener direcciones');
        });

        
        borrarMarcadores();
        

  }


  function obtenerDireccion(marker){
    geocoder.geocode({'latLng': marker.getPosition()}, function(results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                  if (results[0]) {
                    dir= results[0].formatted_address;
                    desplegarDireccion(dir);
                      //document.getElementById("origenRuta").value = dir;
                  }
              }
      });

  }


  function desplegarDireccion(dir){
    if(arregloMarcadores.length == 1) {
          document.getElementById("origenRuta").value = dir;
        } else if (arregloMarcadores.length == 2){
          document.getElementById("destinoRuta").value  = dir;
        }
    
  }