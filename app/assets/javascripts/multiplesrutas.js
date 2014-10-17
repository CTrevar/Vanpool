var map;
var arregloMarcadores = [];
var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var dir;

var directionsService = new google.maps.DirectionsService();
var contadorRutas = 0;
var requestArray = [], renderArray = [];

// 16 Standard Colours for navigation polylines
var colourArray = ['navy', 'grey', 'fuchsia', 'black', 'white', 'lime', 'maroon', 'purple', 'aqua', 'red', 'green', 'silver', 'olive', 'blue', 'yellow', 'teal'];


function initialize() {
    
        //set up del mapa, zoom, centro
      var mapOptions = {
        zoom: 13,
        center: new google.maps.LatLng(19.4329459, -99.1384108)
      };
    
    map = new google.maps.Map(document.getElementById('map-canvas'),
        mapOptions);


    var rendererOptions = { 
      map: map,
      draggable: true
    };

    directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
    
}

  google.maps.event.addDomListener(window, 'load', initialize);


  function agregarRuta(){
    var arregloMarcadores= <%= raw @paradas_ruta.to_json %>;
    var origen = arregloMarcadores[0].latitud+", "+arregloMarcadores[0].longitud;
    var destino = arregloMarcadores[arregloMarcadores.length-1].latitud+", "+arregloMarcadores[arregloMarcadores.length-1].longitud;
    var arregloParadas=[];

        if(arregloMarcadores.length>2){

          for(i= 1; i<arregloMarcadores.length-1;i++){
            var posicionParada = arregloMarcadores[i].latitud+", "+arregloMarcadores[i].longitud;
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

        requestArray.push(request);

        trazarRuta(contadorRutas);

        contadorRutas += 1;

  }


  function trazarRuta (contadorRutas){

    function submitRequest(){
      directionsService.route(requestArray[contadorRutas], directionResults);
    }

    // Used as callback for the above request for current 'i'
    function directionResults(result, status) {
      if (status == google.maps.DirectionsStatus.OK) {
          
          // Create a unique DirectionsRenderer 'i'
          renderArray[contadorRutas] = new google.maps.DirectionsRenderer();
          renderArray[contadorRutas].setMap(map);

          // Some unique options from the colorArray so we can see the routes
          renderArray[contadorRutas].setOptions({
              preserveViewport: true,
              suppressInfoWindows: true,
              polylineOptions: {
                  strokeWeight: 4,
                  strokeOpacity: 0.8,
                  strokeColor: colourArray[contadorRutas]
              },
              markerOptions:{
                  icon:{
                      path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
                      scale: 3,
                      strokeColor: colourArray[contadorRutas]
                  }
              }
          });

          // Use this new renderer with the result
          renderArray[contadorRutas].setDirections(result);
    }



  }

  