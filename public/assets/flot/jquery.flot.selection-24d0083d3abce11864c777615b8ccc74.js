/* Flot plugin for selecting regions of a plot.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The plugin supports these options:

selection: {
	mode: null or "x" or "y" or "xy",
	color: color,
	shape: "round" or "miter" or "bevel",
	minSize: number of pixels
}

Selection support is enabled by setting the mode to one of "x", "y" or "xy".
In "x" mode, the user will only be able to specify the x range, similarly for
"y" mode. For "xy", the selection becomes a rectangle where both ranges can be
specified. "color" is color of the selection (if you need to change the color
later on, you can get to it with plot.getOptions().selection.color). "shape"
is the shape of the corners of the selection.

"minSize" is the minimum size a selection can be in pixels. This value can
be customized to determine the smallest size a selection can be and still
have the selection rectangle be displayed. When customizing this value, the
fact that it refers to pixels, not axis units must be taken into account.
Thus, for example, if there is a bar graph in time mode with BarWidth set to 1
minute, setting "minSize" to 1 will not make the minimum selection size 1
minute, but rather 1 pixel. Note also that setting "minSize" to 0 will prevent
"plotunselected" events from being fired when the user clicks the mouse without
dragging.

When selection support is enabled, a "plotselected" event will be emitted on
the DOM element you passed into the plot function. The event handler gets a
parameter with the ranges selected on the axes, like this:

	placeholder.bind( "plotselected", function( event, ranges ) {
		alert("You selected " + ranges.xaxis.from + " to " + ranges.xaxis.to)
		// similar for yaxis - with multiple axes, the extra ones are in
		// x2axis, x3axis, ...
	});

The "plotselected" event is only fired when the user has finished making the
selection. A "plotselecting" event is fired during the process with the same
parameters as the "plotselected" event, in case you want to know what's
happening while it's happening,

A "plotunselected" event with no arguments is emitted when the user clicks the
mouse to remove the selection. As stated above, setting "minSize" to 0 will
destroy this behavior.

The plugin allso adds the following methods to the plot object:

- setSelection( ranges, preventEvent )

  Set the selection rectangle. The passed in ranges is on the same form as
  returned in the "plotselected" event. If the selection mode is "x", you
  should put in either an xaxis range, if the mode is "y" you need to put in
  an yaxis range and both xaxis and yaxis if the selection mode is "xy", like
  this:

	setSelection({ xaxis: { from: 0, to: 10 }, yaxis: { from: 40, to: 60 } });

  setSelection will trigger the "plotselected" event when called. If you don't
  want that to happen, e.g. if you're inside a "plotselected" handler, pass
  true as the second parameter. If you are using multiple axes, you can
  specify the ranges on any of those, e.g. as x2axis/x3axis/... instead of
  xaxis, the plugin picks the first one it sees.

- clearSelection( preventEvent )

  Clear the selection rectangle. Pass in true to avoid getting a
  "plotunselected" event.

- getSelection()

  Returns the current selection in the same format as the "plotselected"
  event. If there's currently no selection, the function returns null.

*/
!function(t){function e(e){function n(t){p.active&&(c(t),e.getPlaceholder().trigger("plotselecting",[r()]))}function i(e){1==e.which&&(document.body.focus(),void 0!==document.onselectstart&&null==g.onselectstart&&(g.onselectstart=document.onselectstart,document.onselectstart=function(){return!1}),void 0!==document.ondrag&&null==g.ondrag&&(g.ondrag=document.ondrag,document.ondrag=function(){return!1}),l(p.first,e),p.active=!0,m=function(t){o(t)},t(document).one("mouseup",m))}function o(t){return m=null,void 0!==document.onselectstart&&(document.onselectstart=g.onselectstart),void 0!==document.ondrag&&(document.ondrag=g.ondrag),p.active=!1,c(t),f()?a():(e.getPlaceholder().trigger("plotunselected",[]),e.getPlaceholder().trigger("plotselecting",[null])),!1}function r(){if(!f())return null;if(!p.show)return null;var n={},i=p.first,o=p.second;return t.each(e.getAxes(),function(t,e){if(e.used){var r=e.c2p(i[e.direction]),a=e.c2p(o[e.direction]);n[t]={from:Math.min(r,a),to:Math.max(r,a)}}}),n}function a(){var t=r();e.getPlaceholder().trigger("plotselected",[t]),t.xaxis&&t.yaxis&&e.getPlaceholder().trigger("selected",[{x1:t.xaxis.from,y1:t.yaxis.from,x2:t.xaxis.to,y2:t.yaxis.to}])}function s(t,e,n){return t>e?t:e>n?n:e}function l(t,n){var i=e.getOptions(),o=e.getPlaceholder().offset(),r=e.getPlotOffset();t.x=s(0,n.pageX-o.left-r.left,e.width()),t.y=s(0,n.pageY-o.top-r.top,e.height()),"y"==i.selection.mode&&(t.x=t==p.first?0:e.width()),"x"==i.selection.mode&&(t.y=t==p.first?0:e.height())}function c(t){null!=t.pageX&&(l(p.second,t),f()?(p.show=!0,e.triggerRedrawOverlay()):u(!0))}function u(t){p.show&&(p.show=!1,e.triggerRedrawOverlay(),t||e.getPlaceholder().trigger("plotunselected",[]))}function h(t,n){var i,o,r,a,s=e.getAxes();for(var l in s)if(i=s[l],i.direction==n&&(a=n+i.n+"axis",t[a]||1!=i.n||(a=n+"axis"),t[a])){o=t[a].from,r=t[a].to;break}if(t[a]||(i="x"==n?e.getXAxes()[0]:e.getYAxes()[0],o=t[n+"1"],r=t[n+"2"]),null!=o&&null!=r&&o>r){var c=o;o=r,r=c}return{from:o,to:r,axis:i}}function d(t,n){var i,o=e.getOptions();"y"==o.selection.mode?(p.first.x=0,p.second.x=e.width()):(i=h(t,"x"),p.first.x=i.axis.p2c(i.from),p.second.x=i.axis.p2c(i.to)),"x"==o.selection.mode?(p.first.y=0,p.second.y=e.height()):(i=h(t,"y"),p.first.y=i.axis.p2c(i.from),p.second.y=i.axis.p2c(i.to)),p.show=!0,e.triggerRedrawOverlay(),!n&&f()&&a()}function f(){var t=e.getOptions().selection.minSize;return Math.abs(p.second.x-p.first.x)>=t&&Math.abs(p.second.y-p.first.y)>=t}var p={first:{x:-1,y:-1},second:{x:-1,y:-1},show:!1,active:!1},g={},m=null;e.clearSelection=u,e.setSelection=d,e.getSelection=r,e.hooks.bindEvents.push(function(t,e){var o=t.getOptions();null!=o.selection.mode&&(e.mousemove(n),e.mousedown(i))}),e.hooks.drawOverlay.push(function(e,n){if(p.show&&f()){var i=e.getPlotOffset(),o=e.getOptions();n.save(),n.translate(i.left,i.top);var r=t.color.parse(o.selection.color);n.strokeStyle=r.scale("a",.8).toString(),n.lineWidth=1,n.lineJoin=o.selection.shape,n.fillStyle=r.scale("a",.4).toString();var a=Math.min(p.first.x,p.second.x)+.5,s=Math.min(p.first.y,p.second.y)+.5,l=Math.abs(p.second.x-p.first.x)-1,c=Math.abs(p.second.y-p.first.y)-1;n.fillRect(a,s,l,c),n.strokeRect(a,s,l,c),n.restore()}}),e.hooks.shutdown.push(function(e,o){o.unbind("mousemove",n),o.unbind("mousedown",i),m&&t(document).unbind("mouseup",m)})}t.plot.plugins.push({init:e,options:{selection:{mode:null,color:"#e8cfac",shape:"round",minSize:5}},name:"selection",version:"1.1"})}(jQuery);