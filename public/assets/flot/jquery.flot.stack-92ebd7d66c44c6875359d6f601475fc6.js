/* Flot plugin for stacking data sets rather than overlyaing them.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The plugin assumes the data is sorted on x (or y if stacking horizontally).
For line charts, it is assumed that if a line has an undefined gap (from a
null point), then the line above it should have the same gap - insert zeros
instead of "null" if you want another behaviour. This also holds for the start
and end of the chart. Note that stacking a mix of positive and negative values
in most instances doesn't make sense (so it looks weird).

Two or more series are stacked when their "stack" attribute is set to the same
key (which can be any number or string or just "true"). To specify the default
stack, you can set the stack option like this:

	series: {
		stack: null/false, true, or a key (number/string)
	}

You can also specify it for a single series, like this:

	$.plot( $("#placeholder"), [{
		data: [ ... ],
		stack: true
	}])

The stacking order is determined by the order of the data series in the array
(later series end up on top of the previous).

Internally, the plugin modifies the datapoints in each series, adding an
offset to the y value. For line series, extra data points are inserted through
interpolation. If there's a second y value, it's also adjusted (e.g for bar
charts or filled areas).

*/
!function(t){function e(t){function e(t,e){for(var n=null,i=0;i<e.length&&t!=e[i];++i)e[i].stack==t.stack&&(n=e[i]);return n}function n(t,n,i){if(null!=n.stack&&n.stack!==!1){var o=e(n,t.getData());if(o){for(var r,a,s,l,c,u,h,d,f=i.pointsize,p=i.points,g=o.datapoints.pointsize,m=o.datapoints.points,v=[],y=n.lines.show,x=n.bars.horizontal,b=f>2&&(x?i.format[2].x:i.format[2].y),w=y&&n.lines.steps,k=!0,C=x?1:0,T=x?0:1,$=0,S=0;;){if($>=p.length)break;if(h=v.length,null==p[$]){for(d=0;f>d;++d)v.push(p[$+d]);$+=f}else if(S>=m.length){if(!y)for(d=0;f>d;++d)v.push(p[$+d]);$+=f}else if(null==m[S]){for(d=0;f>d;++d)v.push(null);k=!0,S+=g}else{if(r=p[$+C],a=p[$+T],l=m[S+C],c=m[S+T],u=0,r==l){for(d=0;f>d;++d)v.push(p[$+d]);v[h+T]+=c,u=c,$+=f,S+=g}else if(r>l){if(y&&$>0&&null!=p[$-f]){for(s=a+(p[$-f+T]-a)*(l-r)/(p[$-f+C]-r),v.push(l),v.push(s+c),d=2;f>d;++d)v.push(p[$+d]);u=c}S+=g}else{if(k&&y){$+=f;continue}for(d=0;f>d;++d)v.push(p[$+d]);y&&S>0&&null!=m[S-g]&&(u=c+(m[S-g+T]-c)*(r-l)/(m[S-g+C]-l)),v[h+T]+=u,$+=f}k=!1,h!=v.length&&b&&(v[h+2]+=u)}if(w&&h!=v.length&&h>0&&null!=v[h]&&v[h]!=v[h-f]&&v[h+1]!=v[h-f+1]){for(d=0;f>d;++d)v[h+f+d]=v[h+d];v[h+1]=v[h-f+1]}}i.points=v}}}t.hooks.processDatapoints.push(n)}var n={series:{stack:null}};t.plot.plugins.push({init:e,options:n,name:"stack",version:"1.2"})}(jQuery);