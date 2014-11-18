/* Flot plugin for thresholding data.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The plugin supports these options:

	series: {
		threshold: {
			below: number
			color: colorspec
		}
	}

It can also be applied to a single series, like this:

	$.plot( $("#placeholder"), [{
		data: [ ... ],
		threshold: { ... }
	}])

An array can be passed for multiple thresholding, like this:

	threshold: [{
		below: number1
		color: color1
	},{
		below: number2
		color: color2
	}]

These multiple threshold objects can be passed in any order since they are
sorted by the processing function.

The data points below "below" are drawn with the specified color. This makes
it easy to mark points below 0, e.g. for budget data.

Internally, the plugin works by splitting the data into two series, above and
below the threshold. The extra series below the threshold will have its label
cleared and the special "originSeries" attribute set to the original series.
You may need to check for this in hover events.

*/
!function(t){function e(e){function n(e,n,i,o,r){var a,s,l,c,u,h=i.pointsize,d=t.extend({},n);d.datapoints={points:[],pointsize:h,format:i.format},d.label=null,d.color=r,d.threshold=null,d.originSeries=n,d.data=[];var f,p=i.points,g=n.lines.show,m=[],v=[];for(a=0;a<p.length;a+=h){if(s=p[a],l=p[a+1],u=c,c=o>l?m:v,g&&u!=c&&null!=s&&a>0&&null!=p[a-h]){var y=s+(o-l)*(s-p[a-h])/(l-p[a-h+1]);for(u.push(y),u.push(o),f=2;h>f;++f)u.push(p[a+f]);for(c.push(null),c.push(null),f=2;h>f;++f)c.push(p[a+f]);for(c.push(y),c.push(o),f=2;h>f;++f)c.push(p[a+f])}for(c.push(s),c.push(l),f=2;h>f;++f)c.push(p[a+f])}if(i.points=v,d.datapoints.points=m,d.datapoints.points.length>0){var x=t.inArray(n,e.getData());e.getData().splice(x+1,0,d)}}function i(e,i,o){i.threshold&&(i.threshold instanceof Array?(i.threshold.sort(function(t,e){return t.below-e.below}),t(i.threshold).each(function(t,r){n(e,i,o,r.below,r.color)})):n(e,i,o,i.threshold.below,i.threshold.color))}e.hooks.processDatapoints.push(i)}var n={series:{threshold:null}};t.plot.plugins.push({init:e,options:n,name:"threshold",version:"1.2"})}(jQuery);