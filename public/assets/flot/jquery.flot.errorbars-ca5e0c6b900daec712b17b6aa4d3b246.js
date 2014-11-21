/* Flot plugin for plotting error bars.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

Error bars are used to show standard deviation and other statistical
properties in a plot.

* Created by Rui Pereira  -  rui (dot) pereira (at) gmail (dot) com

This plugin allows you to plot error-bars over points. Set "errorbars" inside
the points series to the axis name over which there will be error values in
your data array (*even* if you do not intend to plot them later, by setting
"show: null" on xerr/yerr).

The plugin supports these options:

	series: {
		points: {
			errorbars: "x" or "y" or "xy",
			xerr: {
				show: null/false or true,
				asymmetric: null/false or true,
				upperCap: null or "-" or function,
				lowerCap: null or "-" or function,
				color: null or color,
				radius: null or number
			},
			yerr: { same options as xerr }
		}
	}

Each data point array is expected to be of the type:

	"x"  [ x, y, xerr ]
	"y"  [ x, y, yerr ]
	"xy" [ x, y, xerr, yerr ]

Where xerr becomes xerr_lower,xerr_upper for the asymmetric error case, and
equivalently for yerr. Eg., a datapoint for the "xy" case with symmetric
error-bars on X and asymmetric on Y would be:

	[ x, y, xerr, yerr_lower, yerr_upper ]

By default no end caps are drawn. Setting upperCap and/or lowerCap to "-" will
draw a small cap perpendicular to the error bar. They can also be set to a
user-defined drawing function, with (ctx, x, y, radius) as parameters, as eg.

	function drawSemiCircle( ctx, x, y, radius ) {
		ctx.beginPath();
		ctx.arc( x, y, radius, 0, Math.PI, false );
		ctx.moveTo( x - radius, y );
		ctx.lineTo( x + radius, y );
		ctx.stroke();
	}

Color and radius both default to the same ones of the points series if not
set. The independent radius parameter on xerr/yerr is useful for the case when
we may want to add error-bars to a line, without showing the interconnecting
points (with radius: 0), and still showing end caps on the error-bars.
shadowSize and lineWidth are derived as well from the points series.

*/
!function(t){function e(t,e,n,i){if(e.points.errorbars){var o=[{x:!0,number:!0,required:!0},{y:!0,number:!0,required:!0}],r=e.points.errorbars;("x"==r||"xy"==r)&&(e.points.xerr.asymmetric?(o.push({x:!0,number:!0,required:!0}),o.push({x:!0,number:!0,required:!0})):o.push({x:!0,number:!0,required:!0})),("y"==r||"xy"==r)&&(e.points.yerr.asymmetric?(o.push({y:!0,number:!0,required:!0}),o.push({y:!0,number:!0,required:!0})):o.push({y:!0,number:!0,required:!0})),i.format=o}}function n(t,e){var n=t.datapoints.points,i=null,o=null,r=null,s=null,a=t.points.xerr,l=t.points.yerr,c=t.points.errorbars;"x"==c||"xy"==c?a.asymmetric?(i=n[e+2],o=n[e+3],"xy"==c&&(l.asymmetric?(r=n[e+4],s=n[e+5]):r=n[e+4])):(i=n[e+2],"xy"==c&&(l.asymmetric?(r=n[e+3],s=n[e+4]):r=n[e+3])):"y"==c&&(l.asymmetric?(r=n[e+2],s=n[e+3]):r=n[e+2]),null==o&&(o=i),null==s&&(s=r);var u=[i,o,r,s];return a.show||(u[0]=null,u[1]=null),l.show||(u[2]=null,u[3]=null),u}function i(t,e,i){var r=i.datapoints.points,s=i.datapoints.pointsize,a=[i.xaxis,i.yaxis],l=i.points.radius,c=[i.points.xerr,i.points.yerr],u=!1;if(a[0].p2c(a[0].max)<a[0].p2c(a[0].min)){u=!0;var h=c[0].lowerCap;c[0].lowerCap=c[0].upperCap,c[0].upperCap=h}var d=!1;if(a[1].p2c(a[1].min)<a[1].p2c(a[1].max)){d=!0;var h=c[1].lowerCap;c[1].lowerCap=c[1].upperCap,c[1].upperCap=h}for(var f=0;f<i.datapoints.points.length;f+=s)for(var p=n(i,f),g=0;g<c.length;g++){var m=[a[g].min,a[g].max];if(p[g*c.length]){var v=r[f],y=r[f+1],b=[v,y][g]+p[g*c.length+1],w=[v,y][g]-p[g*c.length];if("x"==c[g].err&&(y>a[1].max||y<a[1].min||b<a[0].min||w>a[0].max))continue;if("y"==c[g].err&&(v>a[0].max||v<a[0].min||b<a[1].min||w>a[1].max))continue;var x=!0,C=!0;if(b>m[1]&&(x=!1,b=m[1]),w<m[0]&&(C=!1,w=m[0]),"x"==c[g].err&&u||"y"==c[g].err&&d){var h=w;w=b,b=h,h=C,C=x,x=h,h=m[0],m[0]=m[1],m[1]=h}v=a[0].p2c(v),y=a[1].p2c(y),b=a[g].p2c(b),w=a[g].p2c(w),m[0]=a[g].p2c(m[0]),m[1]=a[g].p2c(m[1]);var k=c[g].lineWidth?c[g].lineWidth:i.points.lineWidth,$=null!=i.points.shadowSize?i.points.shadowSize:i.shadowSize;if(k>0&&$>0){var T=$/2;e.lineWidth=T,e.strokeStyle="rgba(0,0,0,0.1)",o(e,c[g],v,y,b,w,x,C,l,T+T/2,m),e.strokeStyle="rgba(0,0,0,0.2)",o(e,c[g],v,y,b,w,x,C,l,T/2,m)}e.strokeStyle=c[g].color?c[g].color:i.color,e.lineWidth=k,o(e,c[g],v,y,b,w,x,C,l,0,m)}}}function o(e,n,i,o,s,a,l,c,u,h,d){o+=h,s+=h,a+=h,"x"==n.err?(s>i+u?r(e,[[s,o],[Math.max(i+u,d[0]),o]]):l=!1,i-u>a?r(e,[[Math.min(i-u,d[1]),o],[a,o]]):c=!1):(o-u>s?r(e,[[i,s],[i,Math.min(o-u,d[0])]]):l=!1,a>o+u?r(e,[[i,Math.max(o+u,d[1])],[i,a]]):c=!1),u=null!=n.radius?n.radius:u,l&&("-"==n.upperCap?"x"==n.err?r(e,[[s,o-u],[s,o+u]]):r(e,[[i-u,s],[i+u,s]]):t.isFunction(n.upperCap)&&("x"==n.err?n.upperCap(e,s,o,u):n.upperCap(e,i,s,u))),c&&("-"==n.lowerCap?"x"==n.err?r(e,[[a,o-u],[a,o+u]]):r(e,[[i-u,a],[i+u,a]]):t.isFunction(n.lowerCap)&&("x"==n.err?n.lowerCap(e,a,o,u):n.lowerCap(e,i,a,u)))}function r(t,e){t.beginPath(),t.moveTo(e[0][0],e[0][1]);for(var n=1;n<e.length;n++)t.lineTo(e[n][0],e[n][1]);t.stroke()}function s(e,n){var o=e.getPlotOffset();n.save(),n.translate(o.left,o.top),t.each(e.getData(),function(t,o){o.points.errorbars&&(o.points.xerr.show||o.points.yerr.show)&&i(e,n,o)}),n.restore()}function a(t){t.hooks.processRawData.push(e),t.hooks.draw.push(s)}var l={series:{points:{errorbars:null,xerr:{err:"x",show:null,asymmetric:null,upperCap:null,lowerCap:null,color:null,radius:null},yerr:{err:"y",show:null,asymmetric:null,upperCap:null,lowerCap:null,color:null,radius:null}}}};t.plot.plugins.push({init:a,options:l,name:"errorbars",version:"1.0"})}(jQuery);