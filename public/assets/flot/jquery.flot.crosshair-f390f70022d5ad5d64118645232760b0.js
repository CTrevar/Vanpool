/* Flot plugin for showing crosshairs when the mouse hovers over the plot.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The plugin supports these options:

	crosshair: {
		mode: null or "x" or "y" or "xy"
		color: color
		lineWidth: number
	}

Set the mode to one of "x", "y" or "xy". The "x" mode enables a vertical
crosshair that lets you trace the values on the x axis, "y" enables a
horizontal crosshair and "xy" enables them both. "color" is the color of the
crosshair (default is "rgba(170, 0, 0, 0.80)"), "lineWidth" is the width of
the drawn lines (default is 1).

The plugin also adds four public methods:

  - setCrosshair( pos )

    Set the position of the crosshair. Note that this is cleared if the user
    moves the mouse. "pos" is in coordinates of the plot and should be on the
    form { x: xpos, y: ypos } (you can use x2/x3/... if you're using multiple
    axes), which is coincidentally the same format as what you get from a
    "plothover" event. If "pos" is null, the crosshair is cleared.

  - clearCrosshair()

    Clear the crosshair.

  - lockCrosshair(pos)

    Cause the crosshair to lock to the current location, no longer updating if
    the user moves the mouse. Optionally supply a position (passed on to
    setCrosshair()) to move it to.

    Example usage:

	var myFlot = $.plot( $("#graph"), ..., { crosshair: { mode: "x" } } };
	$("#graph").bind( "plothover", function ( evt, position, item ) {
		if ( item ) {
			// Lock the crosshair to the data point being hovered
			myFlot.lockCrosshair({
				x: item.datapoint[ 0 ],
				y: item.datapoint[ 1 ]
			});
		} else {
			// Return normal crosshair operation
			myFlot.unlockCrosshair();
		}
	});

  - unlockCrosshair()

    Free the crosshair to move again after locking it.
*/
!function(t){function e(t){function e(){i.locked||-1!=i.x&&(i.x=-1,t.triggerRedrawOverlay())}function n(e){if(!i.locked){if(t.getSelection&&t.getSelection())return void(i.x=-1);var n=t.offset();i.x=Math.max(0,Math.min(e.pageX-n.left,t.width())),i.y=Math.max(0,Math.min(e.pageY-n.top,t.height())),t.triggerRedrawOverlay()}}var i={x:-1,y:-1,locked:!1};t.setCrosshair=function(e){if(e){var n=t.p2c(e);i.x=Math.max(0,Math.min(n.left,t.width())),i.y=Math.max(0,Math.min(n.top,t.height()))}else i.x=-1;t.triggerRedrawOverlay()},t.clearCrosshair=t.setCrosshair,t.lockCrosshair=function(e){e&&t.setCrosshair(e),i.locked=!0},t.unlockCrosshair=function(){i.locked=!1},t.hooks.bindEvents.push(function(t,i){t.getOptions().crosshair.mode&&(i.mouseout(e),i.mousemove(n))}),t.hooks.drawOverlay.push(function(t,e){var n=t.getOptions().crosshair;if(n.mode){var o=t.getPlotOffset();if(e.save(),e.translate(o.left,o.top),-1!=i.x){var r=t.getOptions().crosshair.lineWidth%2===0?0:.5;if(e.strokeStyle=n.color,e.lineWidth=n.lineWidth,e.lineJoin="round",e.beginPath(),-1!=n.mode.indexOf("x")){var s=Math.round(i.x)+r;e.moveTo(s,0),e.lineTo(s,t.height())}if(-1!=n.mode.indexOf("y")){var a=Math.round(i.y)+r;e.moveTo(0,a),e.lineTo(t.width(),a)}e.stroke()}e.restore()}}),t.hooks.shutdown.push(function(t,i){i.unbind("mouseout",e),i.unbind("mousemove",n)})}var n={crosshair:{mode:null,color:"rgba(170, 0, 0, 0.80)",lineWidth:1}};t.plot.plugins.push({init:e,options:n,name:"crosshair",version:"1.0"})}(jQuery);