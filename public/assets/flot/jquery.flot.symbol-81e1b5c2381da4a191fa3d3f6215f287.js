/* Flot plugin that adds some extra symbols for plotting points.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The symbols are accessed as strings through the standard symbol options:

	series: {
		points: {
			symbol: "square" // or "diamond", "triangle", "cross"
		}
	}

*/
!function(t){function e(t,e){var n={square:function(t,e,n,i){var o=i*Math.sqrt(Math.PI)/2;t.rect(e-o,n-o,o+o,o+o)},diamond:function(t,e,n,i){var o=i*Math.sqrt(Math.PI/2);t.moveTo(e-o,n),t.lineTo(e,n-o),t.lineTo(e+o,n),t.lineTo(e,n+o),t.lineTo(e-o,n)},triangle:function(t,e,n,i,o){var r=i*Math.sqrt(2*Math.PI/Math.sin(Math.PI/3)),a=r*Math.sin(Math.PI/3);t.moveTo(e-r/2,n+a/2),t.lineTo(e+r/2,n+a/2),o||(t.lineTo(e,n-a/2),t.lineTo(e-r/2,n+a/2))},cross:function(t,e,n,i){var o=i*Math.sqrt(Math.PI)/2;t.moveTo(e-o,n-o),t.lineTo(e+o,n+o),t.moveTo(e-o,n+o),t.lineTo(e+o,n-o)}},i=e.points.symbol;n[i]&&(e.points.symbol=n[i])}function n(t){t.hooks.processDatapoints.push(e)}t.plot.plugins.push({init:n,name:"symbols",version:"1.0"})}(jQuery);