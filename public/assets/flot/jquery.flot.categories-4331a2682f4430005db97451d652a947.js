/* Flot plugin for plotting textual data or categories.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

Consider a dataset like [["February", 34], ["March", 20], ...]. This plugin
allows you to plot such a dataset directly.

To enable it, you must specify mode: "categories" on the axis with the textual
labels, e.g.

	$.plot("#placeholder", data, { xaxis: { mode: "categories" } });

By default, the labels are ordered as they are met in the data series. If you
need a different ordering, you can specify "categories" on the axis options
and list the categories there:

	xaxis: {
		mode: "categories",
		categories: ["February", "March", "April"]
	}

If you need to customize the distances between the categories, you can specify
"categories" as an object mapping labels to values

	xaxis: {
		mode: "categories",
		categories: { "February": 1, "March": 3, "April": 4 }
	}

If you don't specify all categories, the remaining categories will be numbered
from the max value plus 1 (with a spacing of 1 between each).

Internally, the plugin works by transforming the input data through an auto-
generated mapping where the first category becomes 0, the second 1, etc.
Hence, a point like ["February", 34] becomes [0, 34] internally in Flot (this
is visible in hover and click events that return numbers rather than the
category labels). The plugin also overrides the tick generator to spit out the
categories as ticks instead of the values.

If you need to map a value back to its label, the mapping is always accessible
as "categories" on the axis object, e.g. plot.getAxes().xaxis.categories.

*/
!function(t){function e(t,e,n,i){var o="categories"==e.xaxis.options.mode,r="categories"==e.yaxis.options.mode;if(o||r){var s=i.format;if(!s){var a=e;if(s=[],s.push({x:!0,number:!0,required:!0}),s.push({y:!0,number:!0,required:!0}),a.bars.show||a.lines.show&&a.lines.fill){var l=!!(a.bars.show&&a.bars.zero||a.lines.show&&a.lines.zero);s.push({y:!0,number:!0,required:!1,defaultValue:0,autoscale:l}),a.bars.horizontal&&(delete s[s.length-1].y,s[s.length-1].x=!0)}i.format=s}for(var c=0;c<s.length;++c)s[c].x&&o&&(s[c].number=!1),s[c].y&&r&&(s[c].number=!1)}}function n(t){var e=-1;for(var n in t)t[n]>e&&(e=t[n]);return e+1}function i(t){var e=[];for(var n in t.categories){var i=t.categories[n];i>=t.min&&i<=t.max&&e.push([i,n])}return e.sort(function(t,e){return t[0]-e[0]}),e}function o(e,n,o){if("categories"==e[n].options.mode){if(!e[n].categories){var s={},a=e[n].options.categories||{};if(t.isArray(a))for(var l=0;l<a.length;++l)s[a[l]]=l;else for(var c in a)s[c]=a[c];e[n].categories=s}e[n].options.ticks||(e[n].options.ticks=i),r(o,n,e[n].categories)}}function r(t,e,i){for(var o=t.points,r=t.pointsize,s=t.format,a=e.charAt(0),l=n(i),c=0;c<o.length;c+=r)if(null!=o[c])for(var u=0;r>u;++u){var h=o[c+u];null!=h&&s[u][a]&&(h in i||(i[h]=l,++l),o[c+u]=i[h])}}function s(t,e,n){o(e,"xaxis",n),o(e,"yaxis",n)}function a(t){t.hooks.processRawData.push(e),t.hooks.processDatapoints.push(s)}var l={xaxis:{categories:null},yaxis:{categories:null}};t.plot.plugins.push({init:a,options:l,name:"categories",version:"1.0"})}(jQuery);