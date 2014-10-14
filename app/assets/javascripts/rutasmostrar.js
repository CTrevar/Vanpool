
var map;
var arregloMarcadores = [];
var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var dir;


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
      draggable: false
    };

    directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
    trazarRuta();
    
}

  google.maps.event.addDomListener(window, 'load', initialize);



   function trazarRuta(){
    var arregloMarcadores= <%= raw @paradas_ruta.to_json %>;
    for(i= 0; i<=arregloMarcadores.length-1;i++){
      if(arregloMarcadores[i].posicion==0)
            var primera = arregloMarcadores[i];
        if(arregloMarcadores[i].posicion==arregloMarcadores.length-1)
          var ultima = arregloMarcadores[i];
            
    }

    var origen = primera.latitud+", "+primera.longitud;
    var destino = ultima.latitud+", "+ultima.longitud;
    var arregloParadas=[];

        if(arregloMarcadores.length>2){

          for(i= 0; i<=arregloMarcadores.length-1;i++){
            var posicionParada = arregloMarcadores[i].latitud+", "+arregloMarcadores[i].longitud;
            
            if(arregloMarcadores[i].posicion!=arregloMarcadores.length-1 && arregloMarcadores[i].posicion!=0){
              arregloParadas[arregloMarcadores[i].posicion-1]={
                                location: posicionParada,
                                stopover: true
                              };  
            }
                        
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
                 
          }
          else
            alert ('no se pudo obtener direcciones');
        });

        

    }
  