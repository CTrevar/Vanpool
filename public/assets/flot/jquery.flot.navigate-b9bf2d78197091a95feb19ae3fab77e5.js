/* Flot plugin for adding the ability to pan and zoom the plot.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The default behaviour is double click and scrollwheel up/down to zoom in, drag
to pan. The plugin defines plot.zoom({ center }), plot.zoomOut() and
plot.pan( offset ) so you easily can add custom controls. It also fires
"plotpan" and "plotzoom" events, useful for synchronizing plots.

The plugin supports these options:

	zoom: {
		interactive: false
		trigger: "dblclick" // or "click" for single click
		amount: 1.5         // 2 = 200% (zoom in), 0.5 = 50% (zoom out)
	}

	pan: {
		interactive: false
		cursor: "move"      // CSS mouse cursor value used when dragging, e.g. "pointer"
		frameRate: 20
	}

	xaxis, yaxis, x2axis, y2axis: {
		zoomRange: null  // or [ number, number ] (min range, max range) or false
		panRange: null   // or [ number, number ] (min, max) or false
	}

"interactive" enables the built-in drag/click behaviour. If you enable
interactive for pan, then you'll have a basic plot that supports moving
around; the same for zoom.

"amount" specifies the default amount to zoom in (so 1.5 = 150%) relative to
the current viewport.

"cursor" is a standard CSS mouse cursor string used for visual feedback to the
user when dragging.

"frameRate" specifies the maximum number of times per second the plot will
update itself while the user is panning around on it (set to null to disable
intermediate pans, the plot will then not update until the mouse button is
released).

"zoomRange" is the interval in which zooming can happen, e.g. with zoomRange:
[1, 100] the zoom will never scale the axis so that the difference between min
and max is smaller than 1 or larger than 100. You can set either end to null
to ignore, e.g. [1, null]. If you set zoomRange to false, zooming on that axis
will be disabled.

"panRange" confines the panning to stay within a range, e.g. with panRange:
[-10, 20] panning stops at -10 in one end and at 20 in the other. Either can
be null, e.g. [-10, null]. If you set panRange to false, panning on that axis
will be disabled.

Example API usage:

	plot = $.plot(...);

	// zoom default amount in on the pixel ( 10, 20 )
	plot.zoom({ center: { left: 10, top: 20 } });

	// zoom out again
	plot.zoomOut({ center: { left: 10, top: 20 } });

	// zoom 200% in on the pixel (10, 20)
	plot.zoom({ amount: 2, center: { left: 10, top: 20 } });

	// pan 100 pixels to the left and 20 down
	plot.pan({ left: -100, top: 20 })

Here, "center" specifies where the center of the zooming should happen. Note
that this is defined in pixel space, not the space of the data points (you can
use the p2c helpers on the axes in Flot to help you convert between these).

"amount" is the amount to zoom the viewport relative to the current range, so
1 is 100% (i.e. no change), 1.5 is 150% (zoom in), 0.7 is 70% (zoom out). You
can set the default in the options.

*/
/*
jquery.event.drag.js ~ v1.5 ~ Copyright (c) 2008, Three Dub Media (http://threedubmedia.com)
Licensed under the MIT License ~ http://threedubmedia.googlecode.com/files/MIT-LICENSE.txt
*/
!function(t){function e(o){var c,u=this,h=o.data||{};if(h.elem)u=o.dragTarget=h.elem,o.dragProxy=l.proxy||u,o.cursorOffsetX=h.pageX-h.left,o.cursorOffsetY=h.pageY-h.top,o.offsetX=o.pageX-o.cursorOffsetX,o.offsetY=o.pageY-o.cursorOffsetY;else if(l.dragging||h.which>0&&o.which!=h.which||t(o.target).is(h.not))return;switch(o.type){case"mousedown":return t.extend(h,t(u).offset(),{elem:u,target:o.target,pageX:o.pageX,pageY:o.pageY}),a.add(document,"mousemove mouseup",e,h),r(u,!1),l.dragging=null,!1;case!l.dragging&&"mousemove":if(i(o.pageX-h.pageX)+i(o.pageY-h.pageY)<h.distance)break;o.target=h.target,c=n(o,"dragstart",u),c!==!1&&(l.dragging=u,l.proxy=o.dragProxy=t(c||u)[0]);case"mousemove":if(l.dragging){if(c=n(o,"drag",u),s.drop&&(s.drop.allowed=c!==!1,s.drop.handler(o)),c!==!1)break;o.type="mouseup"}case"mouseup":a.remove(document,"mousemove mouseup",e),l.dragging&&(s.drop&&s.drop.handler(o),n(o,"dragend",u)),r(u,!0),l.dragging=l.proxy=h.elem=!1}return!0}function n(e,n,i){e.type=n;var o=t.event.dispatch.call(i,e);return o===!1?!1:o||e.result}function i(t){return Math.pow(t,2)}function o(){return l.dragging===!1}function r(t,e){t&&(t.unselectable=e?"off":"on",t.onselectstart=function(){return e},t.style&&(t.style.MozUserSelect=e?"":"none"))}t.fn.drag=function(t,e,n){return e&&this.bind("dragstart",t),n&&this.bind("dragend",n),t?this.bind("drag",e?e:t):this.trigger("drag")};var a=t.event,s=a.special,l=s.drag={not:":input",distance:0,which:1,dragging:!1,setup:function(n){n=t.extend({distance:l.distance,which:l.which,not:l.not},n||{}),n.distance=i(n.distance),a.add(this,"mousedown",e,n),this.attachEvent&&this.attachEvent("ondragstart",o)},teardown:function(){a.remove(this,"mousedown",e),this===l.dragging&&(l.dragging=l.proxy=!1),r(this,!0),this.detachEvent&&this.detachEvent("ondragstart",o)}};s.dragstart=s.dragend={setup:function(){},teardown:function(){}}}(jQuery),/* jquery.mousewheel.min.js
 * Copyright (c) 2011 Brandon Aaron (http://brandonaaron.net)
 * Licensed under the MIT License (LICENSE.txt).
 * Thanks to: http://adomas.org/javascript-mouse-wheel/ for some pointers.
 * Thanks to: Mathias Bank(http://www.mathias-bank.de) for a scope bug fix.
 * Thanks to: Seamus Leahy for adding deltaX and deltaY
 *
 * Version: 3.0.6
 *
 * Requires: 1.2.2+
 */
function(t){function e(e){var n=e||window.event,i=[].slice.call(arguments,1),o=0,r=0,a=0,e=t.event.fix(n);return e.type="mousewheel",n.wheelDelta&&(o=n.wheelDelta/120),n.detail&&(o=-n.detail/3),a=o,void 0!==n.axis&&n.axis===n.HORIZONTAL_AXIS&&(a=0,r=-1*o),void 0!==n.wheelDeltaY&&(a=n.wheelDeltaY/120),void 0!==n.wheelDeltaX&&(r=-1*n.wheelDeltaX/120),i.unshift(e,o,r,a),(t.event.dispatch||t.event.handle).apply(this,i)}var n=["DOMMouseScroll","mousewheel"];if(t.event.fixHooks)for(var i=n.length;i;)t.event.fixHooks[n[--i]]=t.event.mouseHooks;t.event.special.mousewheel={setup:function(){if(this.addEventListener)for(var t=n.length;t;)this.addEventListener(n[--t],e,!1);else this.onmousewheel=e},teardown:function(){if(this.removeEventListener)for(var t=n.length;t;)this.removeEventListener(n[--t],e,!1);else this.onmousewheel=null}},t.fn.extend({mousewheel:function(t){return t?this.bind("mousewheel",t):this.trigger("mousewheel")},unmousewheel:function(t){return this.unbind("mousewheel",t)}})}(jQuery),function(t){function e(e){function n(t,n){var i=e.offset();i.left=t.pageX-i.left,i.top=t.pageY-i.top,n?e.zoomOut({center:i}):e.zoom({center:i})}function i(t,e){return t.preventDefault(),n(t,0>e),!1}function o(t){if(1!=t.which)return!1;var n=e.getPlaceholder().css("cursor");n&&(c=n),e.getPlaceholder().css("cursor",e.getOptions().pan.cursor),u=t.pageX,h=t.pageY}function r(t){var n=e.getOptions().pan.frameRate;!d&&n&&(d=setTimeout(function(){e.pan({left:u-t.pageX,top:h-t.pageY}),u=t.pageX,h=t.pageY,d=null},1/n*1e3))}function a(t){d&&(clearTimeout(d),d=null),e.getPlaceholder().css("cursor",c),e.pan({left:u-t.pageX,top:h-t.pageY})}function s(t,e){var s=t.getOptions();s.zoom.interactive&&(e[s.zoom.trigger](n),e.mousewheel(i)),s.pan.interactive&&(e.bind("dragstart",{distance:10},o),e.bind("drag",r),e.bind("dragend",a))}function l(t,e){e.unbind(t.getOptions().zoom.trigger,n),e.unbind("mousewheel",i),e.unbind("dragstart",o),e.unbind("drag",r),e.unbind("dragend",a),d&&clearTimeout(d)}var c="default",u=0,h=0,d=null;e.zoomOut=function(t){t||(t={}),t.amount||(t.amount=e.getOptions().zoom.amount),t.amount=1/t.amount,e.zoom(t)},e.zoom=function(n){n||(n={});var i=n.center,o=n.amount||e.getOptions().zoom.amount,r=e.width(),a=e.height();i||(i={left:r/2,top:a/2});var s=i.left/r,l=i.top/a,c={x:{min:i.left-s*r/o,max:i.left+(1-s)*r/o},y:{min:i.top-l*a/o,max:i.top+(1-l)*a/o}};t.each(e.getAxes(),function(t,e){var n=e.options,i=c[e.direction].min,o=c[e.direction].max,r=n.zoomRange,a=n.panRange;if(r!==!1){if(i=e.c2p(i),o=e.c2p(o),i>o){var s=i;i=o,o=s}a&&(null!=a[0]&&i<a[0]&&(i=a[0]),null!=a[1]&&o>a[1]&&(o=a[1]));var l=o-i;r&&(null!=r[0]&&l<r[0]||null!=r[1]&&l>r[1])||(n.min=i,n.max=o)}}),e.setupGrid(),e.draw(),n.preventEvent||e.getPlaceholder().trigger("plotzoom",[e,n])},e.pan=function(n){var i={x:+n.left,y:+n.top};isNaN(i.x)&&(i.x=0),isNaN(i.y)&&(i.y=0),t.each(e.getAxes(),function(t,e){var n,o,r=e.options,a=i[e.direction];n=e.c2p(e.p2c(e.min)+a),o=e.c2p(e.p2c(e.max)+a);var s=r.panRange;s!==!1&&(s&&(null!=s[0]&&s[0]>n&&(a=s[0]-n,n+=a,o+=a),null!=s[1]&&s[1]<o&&(a=s[1]-o,n+=a,o+=a)),r.min=n,r.max=o)}),e.setupGrid(),e.draw(),n.preventEvent||e.getPlaceholder().trigger("plotpan",[e,n])},e.hooks.bindEvents.push(s),e.hooks.shutdown.push(l)}var n={xaxis:{zoomRange:null,panRange:null},zoom:{interactive:!1,trigger:"dblclick",amount:1.5},pan:{interactive:!1,cursor:"move",frameRate:20}};t.plot.plugins.push({init:e,options:n,name:"navigate",version:"1.3"})}(jQuery);