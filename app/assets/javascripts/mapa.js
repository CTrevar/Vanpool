var map;
var arregloMarcadores = [];
var geocoder = new google.maps.Geocoder();
var infowindow = new google.maps.InfoWindow();
var dir;


function initialize() {
    
        //set up del mapa, zoom, centro
      var mapOptions = {
        zoom: 13
      };
    
    map = new google.maps.Map(document.getElementById('map-canvas'),
        mapOptions);


    var lineSymbol = {
      path: google.maps.SymbolPath.FORWARD_OPEN_ARROW
    };


    var rendererOptions = { 
      map: map,
      draggable: false,
      polylineOptions: {
          strokeWeight: 4,
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
    trazarRuta();
    
}

  google.maps.event.addDomListener(window, 'load', initialize);