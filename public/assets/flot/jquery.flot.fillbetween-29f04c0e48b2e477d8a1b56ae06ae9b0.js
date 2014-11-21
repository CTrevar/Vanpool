/* Flot plugin for computing bottoms for filled line and bar charts.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The case: you've got two series that you want to fill the area between. In Flot
terms, you need to use one as the fill bottom of the other. You can specify the
bottom of each data point as the third coordinate manually, or you can use this
plugin to compute it for you.

In order to name the other series, you need to give it an id, like this:

	var dataset = [
		{ data: [ ... ], id: "foo" } ,         // use default bottom
		{ data: [ ... ], fillBetween: "foo" }, // use first dataset as bottom
	];

	$.plot($("#placeholder"), dataset, { lines: { show: true, fill: true }});

As a convenience, if the id given is a number that doesn't appear as an id in
the series, it is interpreted as the index in the array instead (so fillBetween:
0 can also mean the first series).

Internally, the plugin modifies the datapoints in each series. For line series,
extra data points might be inserted through interpolation. Note that at points
where the bottom line is not defined (due to a null point or start/end of line),
the current line will show a gap too. The algorithm comes from the
jquery.flot.stack.js plugin, possibly some code could be shared.

*/
!function(t){function e(t){function e(t,e){var n;for(n=0;n<e.length;++n)if(e[n].id===t.fillBetween)return e[n];return"number"==typeof t.fillBetween?t.fillBetween<0||t.fillBetween>=e.length?null:e[t.fillBetween]:null}function n(t,n,i){if(null!=n.fillBetween){var o=e(n,t.getData());if(o){for(var r,s,a,l,c,u,h,d,p=i.pointsize,f=i.points,g=o.datapoints.pointsize,m=o.datapoints.points,v=[],y=n.lines.show,b=p>2&&i.format[2].y,w=y&&n.lines.steps,x=!0,C=0,k=0;;){if(C>=f.length)break;if(h=v.length,null==f[C]){for(d=0;p>d;++d)v.push(f[C+d]);C+=p}else if(k>=m.length){if(!y)for(d=0;p>d;++d)v.push(f[C+d]);C+=p}else if(null==m[k]){for(d=0;p>d;++d)v.push(null);x=!0,k+=g}else{if(r=f[C],s=f[C+1],l=m[k],c=m[k+1],u=0,r===l){for(d=0;p>d;++d)v.push(f[C+d]);u=c,C+=p,k+=g}else if(r>l){if(y&&C>0&&null!=f[C-p]){for(a=s+(f[C-p+1]-s)*(l-r)/(f[C-p]-r),v.push(l),v.push(a),d=2;p>d;++d)v.push(f[C+d]);u=c}k+=g}else{if(x&&y){C+=p;continue}for(d=0;p>d;++d)v.push(f[C+d]);y&&k>0&&null!=m[k-g]&&(u=c+(m[k-g+1]-c)*(r-l)/(m[k-g]-l)),C+=p}x=!1,h!==v.length&&b&&(v[h+2]=u)}if(w&&h!==v.length&&h>0&&null!==v[h]&&v[h]!==v[h-p]&&v[h+1]!==v[h-p+1]){for(d=0;p>d;++d)v[h+p+d]=v[h+d];v[h+1]=v[h-p+1]}}i.points=v}}}t.hooks.processDatapoints.push(n)}var n={series:{fillBetween:null}};t.plot.plugins.push({init:e,options:n,name:"fillbetween",version:"1.0"})}(jQuery);