var map;
var arregloMarcadores = [];
var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var dir;

var currentLat;
var currentLng;

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
  document.getElementById("latitud_label").value = currentLat;
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
          obtenerLatLong(event);
          obtenerDireccion();
          
      });

  google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
                calcularDistancia(directionsDisplay.getDirections());
                guardarParadas(directionsDisplay.getDirections().routes[0]);
                desplegarParadas(directionsDisplay.getDirections().routes[0]);
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
          obtenerLatLong(event);
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
      }//(if) más de 2 marcadores

      $("#agregarParadas").html("<%= render :partial => 'paradas_form' %>"); 

                       
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
            guardarParadas(routeDrawn);
            desplegarParadas(routeDrawn);
                 

                               //document.getElementById("destinoRuta").value = response.routes[0].legs[0].distance.text;
            //document.getElementById("origenRuta").value = response.routes[0].legs[0].distance.value;
          }
          else
            alert ('no se pudo obtener direcciones');
        });

        
        borrarMarcadores();
        

  }

  function calcularDistancia(result) {
    var total = 0;
    var mi_ruta = result.routes[0];
    for (var i = 0; i < mi_ruta.legs.length; i++) {
      total += mi_ruta.legs[i].distance.value;
    }
    total = total / 1000.0;
    document.getElementById("latitud_label").value = total;
  }


  function obtenerLatLong(event){
    document.getElementById("latitud_label").value = event.latLng.lat();
    document.getElementById("longitud_label").value = event.latLng.lng();
  }

  function obtenerDireccion(marker){
    geocoder.geocode({'latLng': marker.getPosition()}, function(results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                  if (results[0]) {
                    dir= results[0].formatted_address;
                      //document.getElementById("origenRuta").value = dir;
                  }
              }
      });

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

  function guardarParadas(routeDrawn){
    document.getElementById("textoArea").value = "";
    for (var i = 0; i < routeDrawn.legs.length; i++) {
      var routeSegment = i + 1;
      document.getElementById("textoArea").value += routeDrawn.legs[i].start_address + ' to ';
      document.getElementById("textoArea").value += routeDrawn.legs[i].end_address + '\\\n';
      document.getElementById("textoArea").value += routeDrawn.legs[i].duration.value + '\\\n';
      document.getElementById("textoArea").value += routeDrawn.legs[i].distance.value  +'\\\n' + '\\\n';
    }

    document.getElementById("origenRuta").value = routeDrawn.legs[0].start_address;
    document.getElementById("destinoRuta").value = routeDrawn.legs[routeDrawn.legs.length-1].end_address;

    
  }


  function desplegarParadas(routeDrawn){
    //posicion = routeDrawn.legs.length-1;
    // var ulparadas = document.getElementById("paradasLista");
    //     var liparadas = document.createElement("li");
    //     liparadas.appendChild(document.createTextNode(routeDrawn.legs[posicion].start_address));
    //     liparadas.setAttribute("id","ruta_paradas_attribute_"+posicion+"_nombre");
    //     liparadas.setAttribute("name","ruta[paradas_attributes]["+posicion+"][nombre]");
    //     ulparadas.appendChild(liparadas);
        for (var posicion = 0; posicion < routeDrawn.legs.length; posicion++) {

          document.getElementById("ruta_paradas_attributes_"+posicion+"_nombre").value = routeDrawn.legs[posicion].start_address;
          document.getElementById("ruta_paradas_attributes_"+posicion+"_latitud").value = routeDrawn.legs[posicion].start_location.lat();
          document.getElementById("ruta_paradas_attributes_"+posicion+"_longitud").value = routeDrawn.legs[posicion].start_location.lng();
          document.getElementById("ruta_paradas_attributes_"+posicion+"_posicion").value = posicion;
          document.getElementById("ruta_paradas_attributes_"+posicion+"_tiempo").value = routeDrawn.legs[posicion].duration.value;
          document.getElementById("ruta_paradas_attributes_"+posicion+"_distancia").value =  routeDrawn.legs[posicion].distance.value;
        }

        largo = routeDrawn.legs.length;
        posicionFinal = largo-1;
        document.getElementById("ruta_paradas_attributes_"+largo+"_nombre").value = routeDrawn.legs[posicionFinal].end_address;
          document.getElementById("ruta_paradas_attributes_"+largo+"_latitud").value = routeDrawn.legs[posicionFinal].end_location.lat();
          document.getElementById("ruta_paradas_attributes_"+largo+"_longitud").value = routeDrawn.legs[posicionFinal].end_location.lng();
          document.getElementById("ruta_paradas_attributes_"+largo+"_posicion").value = largo;
          document.getElementById("ruta_paradas_attributes_"+largo+"_tiempo").value = routeDrawn.legs[posicionFinal].duration.value;
          document.getElementById("ruta_paradas_attributes_"+largo+"_distancia").value =  routeDrawn.legs[posicionFinal].distance.value;

    //$('#agregarParadas').html(<%= j render(:partial => 'shared/paradas_form') %>);

  }

  function geocodeMarcador(){
    var address = document.getElementById("origenRuta").value;

    geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      agregarMarcador(results[0].geometry.location);
    } else {
      alert('Geocode falló por: ' + status);
    }
  });


  }