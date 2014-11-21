/* Flot plugin for plotting images.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The data syntax is [ [ image, x1, y1, x2, y2 ], ... ] where (x1, y1) and
(x2, y2) are where you intend the two opposite corners of the image to end up
in the plot. Image must be a fully loaded Javascript image (you can make one
with new Image()). If the image is not complete, it's skipped when plotting.

There are two helpers included for retrieving images. The easiest work the way
that you put in URLs instead of images in the data, like this:

	[ "myimage.png", 0, 0, 10, 10 ]

Then call $.plot.image.loadData( data, options, callback ) where data and
options are the same as you pass in to $.plot. This loads the images, replaces
the URLs in the data with the corresponding images and calls "callback" when
all images are loaded (or failed loading). In the callback, you can then call
$.plot with the data set. See the included example.

A more low-level helper, $.plot.image.load(urls, callback) is also included.
Given a list of URLs, it calls callback with an object mapping from URL to
Image object when all images are loaded or have failed loading.

The plugin supports these options:

	series: {
		images: {
			show: boolean
			anchor: "corner" or "center"
			alpha: [ 0, 1 ]
		}
	}

They can be specified for a specific series:

	$.plot( $("#placeholder"), [{
		data: [ ... ],
		images: { ... }
	])

Note that because the data format is different from usual data points, you
can't use images with anything else in a specific data series.

Setting "anchor" to "center" causes the pixels in the image to be anchored at
the corner pixel centers inside of at the pixel corners, effectively letting
half a pixel stick out to each side in the plot.

A possible future direction could be support for tiling for large images (like
Google Maps).

*/
!function(t){function e(t,e,n){var i=t.getPlotOffset();if(n.images&&n.images.show)for(var o=n.datapoints.points,r=n.datapoints.pointsize,s=0;s<o.length;s+=r){var a,l=o[s],c=o[s+1],u=o[s+2],h=o[s+3],d=o[s+4],p=n.xaxis,f=n.yaxis;if(!(!l||l.width<=0||l.height<=0||(c>h&&(a=h,h=c,c=a),u>d&&(a=d,d=u,u=a),"center"==n.images.anchor&&(a=.5*(h-c)/(l.width-1),c-=a,h+=a,a=.5*(d-u)/(l.height-1),u-=a,d+=a),c==h||u==d||c>=p.max||h<=p.min||u>=f.max||d<=f.min))){var g=0,m=0,v=l.width,y=l.height;c<p.min&&(g+=(v-g)*(p.min-c)/(h-c),c=p.min),h>p.max&&(v+=(v-g)*(p.max-h)/(h-c),h=p.max),u<f.min&&(y+=(m-y)*(f.min-u)/(d-u),u=f.min),d>f.max&&(m+=(m-y)*(f.max-d)/(d-u),d=f.max),c=p.p2c(c),h=p.p2c(h),u=f.p2c(u),d=f.p2c(d),c>h&&(a=h,h=c,c=a),u>d&&(a=d,d=u,u=a),a=e.globalAlpha,e.globalAlpha*=n.images.alpha,e.drawImage(l,g,m,v-g,y-m,c+i.left,u+i.top,h-c,d-u),e.globalAlpha=a}}}function n(t,e,n,i){e.images.show&&(i.format=[{required:!0},{x:!0,number:!0,required:!0},{y:!0,number:!0,required:!0},{x:!0,number:!0,required:!0},{y:!0,number:!0,required:!0}])}function i(t){t.hooks.processRawData.push(n),t.hooks.drawSeries.push(e)}var o={series:{images:{show:!1,alpha:1,anchor:"corner"}}};t.plot.image={},t.plot.image.loadDataImages=function(e,n,i){var o=[],r=[],s=n.series.images.show;t.each(e,function(e,n){(s||n.images.show)&&(n.data&&(n=n.data),t.each(n,function(t,e){"string"==typeof e[0]&&(o.push(e[0]),r.push(e))}))}),t.plot.image.load(o,function(e){t.each(r,function(t,n){var i=n[0];e[i]&&(n[0]=e[i])}),i()})},t.plot.image.load=function(e,n){var i=e.length,o={};0==i&&n({}),t.each(e,function(e,r){var s=function(){--i,o[r]=this,0==i&&n(o)};t("<img />").load(s).error(s).attr("src",r)})},t.plot.plugins.push({init:i,options:o,name:"image",version:"1.1"})}(jQuery);