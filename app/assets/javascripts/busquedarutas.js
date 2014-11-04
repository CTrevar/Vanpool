var map;
var arregloMarcadores = [];
var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var dir;

var currentLat;
var currentLng;
var contador = 0;

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


  var rendererOptions = { 
    map: map,
    draggable: true
  };

  directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);

  //Poner un marcador en el mapa cuando dé clic
  google.maps.event.addListener(map, "click", function(event)
      {
          // agregar un marcador, solamente permite agregar 2 (origen y destino)
          if(arregloMarcadores.length<2){
            agregarMarcador(event.latLng, 2);
          }
          
      });



  //AUTOCOMPLETADO
  // Create the autocomplete object, restricting the search
  // to geographical location types.
  autocompleteOrigen = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('origenRuta')));
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocompleteOrigen, 'place_changed', function() {
    llenarDireccionAutocomplete(0);
  });


  //Destino
  autocompleteDestino = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('destinoRuta')));
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocompleteDestino, 'place_changed', function() {
    llenarDireccionAutocomplete(1);
  });


}

google.maps.event.addDomListener(window, 'load', initialize);

function agregarMarcador(location, posicion) {
      var iconBase = 'http://maps.google.com/mapfiles/kml/paddle/'

      

      //agregar marcador en el mapa con posibilidad de ser movido de lugar
      if (posicion == 0 || contador == 0) {
        var image = new google.maps.MarkerImage(iconBase+'grn-circle.png',
          null,
          null,
          null,
          new google.maps.Size(34, 36));
      } else {
        var image = new google.maps.MarkerImage(iconBase+'red-circle.png',
          null,
          null,
          null,
          new google.maps.Size(34, 36));
      }

      if(posicion== 0 && arregloMarcadores[0]){
        arregloMarcadores[0].setMap(null);
        arregloMarcadores[0].position = location;
        arregloMarcadores[0].setMap(map);
        obtenerDireccion(arregloMarcadores[0]);
      } else if (posicion==1 && arregloMarcadores[1]){
        arregloMarcadores[1].setMap(null);
        arregloMarcadores[1].position = location;
        arregloMarcadores[1].setMap(map);
        obtenerDireccion(arregloMarcadores[1]);
      } else {
        var marker = new google.maps.Marker({
            position: location, 
            map: map,
            draggable: true,
            icon: image
        });

        // agregar el marcador al arreglo de marcadores
        if (posicion == 0 || contador == 0){
          arregloMarcadores [0] = marker;
        } else if (posicion == 1 || contador > 0) {
          arregloMarcadores[1] = marker;
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

      }
      
      

      

      
      

        
      //si es del segundo marcador en adelante, trazar ruta
      if(arregloMarcadores.length==2){

      }//(if) más de 2 marcadores


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
    if(pos == 0) {
      document.getElementById("origenRuta").value = dir;
      document.getElementById("origenLat").value = marker.getPosition().lat();
      document.getElementById("origenLng").value = marker.getPosition().lng();
    } else {
      document.getElementById("destinoRuta").value  = dir;
      document.getElementById("destinoLat").value = marker.getPosition().lat();
      document.getElementById("destinoLng").value = marker.getPosition().lng();
    }


    // if(arregloMarcadores.length == 1) {
          
    //     } else if (arregloMarcadores.length == 2){
          
    //     }
    
  }


  //AUTOCOMPLETADO



function llenarDireccionAutocomplete(posicion){
    //obtener dirección de input
    if(posicion==0) {
      //var address = document.getElementById("origenRuta").value;
      var address = autocompleteOrigen.getPlace();
    } else {
      //var address = document.getElementById("destinoRuta").value;
      var address = autocompleteDestino.getPlace();
    }
    

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