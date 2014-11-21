/* Flot plugin for drawing all elements of a plot on the canvas.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

Flot normally produces certain elements, like axis labels and the legend, using
HTML elements. This permits greater interactivity and customization, and often
looks better, due to cross-browser canvas text inconsistencies and limitations.

It can also be desirable to render the plot entirely in canvas, particularly
if the goal is to save it as an image, or if Flot is being used in a context
where the HTML DOM does not exist, as is the case within Node.js. This plugin
switches out Flot's standard drawing operations for canvas-only replacements.

Currently the plugin supports only axis labels, but it will eventually allow
every element of the plot to be rendered directly to canvas.

The plugin supports these options:

{
    canvas: boolean
}

The "canvas" option controls whether full canvas drawing is enabled, making it
possible to toggle on and off. This is useful when a plot uses HTML text in the
browser, but needs to redraw with canvas text when exporting as an image.

*/
!function(t){function e(e,r){var a=r.Canvas;null==n&&(i=a.prototype.getTextInfo,o=a.prototype.addText,n=a.prototype.render),a.prototype.render=function(){if(!e.getOptions().canvas)return n.call(this);var t=this.context,i=this._textCache;t.save(),t.textBaseline="middle";for(var o in i)if(s.call(i,o)){var r=i[o];for(var a in r)if(s.call(r,a)){var l=r[a],c=!0;for(var u in l)if(s.call(l,u)){var h=l[u],d=h.positions,f=h.lines;c&&(t.fillStyle=h.font.color,t.font=h.font.definition,c=!1);for(var p,g=0;p=d[g];g++)if(p.active)for(var m,v=0;m=p.lines[v];v++)t.fillText(f[v].text,m[0],m[1]);else d.splice(g--,1);0==d.length&&delete l[u]}}}t.restore()},a.prototype.getTextInfo=function(n,o,r,s,a){if(!e.getOptions().canvas)return i.call(this,n,o,r,s,a);var l,c,u,h;if(o=""+o,l="object"==typeof r?r.style+" "+r.variant+" "+r.weight+" "+r.size+"px "+r.family:r,c=this._textCache[n],null==c&&(c=this._textCache[n]={}),u=c[l],null==u&&(u=c[l]={}),h=u[o],null==h){var d=this.context;if("object"!=typeof r){var f=t("<div>&nbsp;</div>").css("position","absolute").addClass("string"==typeof r?r:null).appendTo(this.getTextLayer(n));r={lineHeight:f.height(),style:f.css("font-style"),variant:f.css("font-variant"),weight:f.css("font-weight"),family:f.css("font-family"),color:f.css("color")},r.size=f.css("line-height",1).height(),f.remove()}l=r.style+" "+r.variant+" "+r.weight+" "+r.size+"px "+r.family,h=u[o]={width:0,height:0,positions:[],lines:[],font:{definition:l,color:r.color}},d.save(),d.font=l;for(var p=(o+"").replace(/<br ?\/?>|\r\n|\r/g,"\n").split("\n"),g=0;g<p.length;++g){var m=p[g],v=d.measureText(m);h.width=Math.max(v.width,h.width),h.height+=r.lineHeight,h.lines.push({text:m,width:v.width,height:r.lineHeight})}d.restore()}return h},a.prototype.addText=function(t,n,i,r,s,a,l,c,u){if(!e.getOptions().canvas)return o.call(this,t,n,i,r,s,a,l,c,u);var h=this.getTextInfo(t,r,s,a,l),d=h.positions,f=h.lines;i+=h.height/f.length/2,i=Math.round("middle"==u?i-h.height/2:"bottom"==u?i-h.height:i),window.opera&&window.opera.version().split(".")[0]<12&&(i-=2);for(var p,g=0;p=d[g];g++)if(p.x==n&&p.y==i)return void(p.active=!0);p={active:!0,lines:[],x:n,y:i},d.push(p);for(var m,g=0;m=f[g];g++)p.lines.push("center"==c?[Math.round(n-m.width/2),i]:"right"==c?[Math.round(n-m.width),i]:[Math.round(n),i]),i+=m.height}}var n,i,o,r={canvas:!0},s=Object.prototype.hasOwnProperty;t.plot.plugins.push({init:e,options:r,name:"canvas",version:"1.0"})}(jQuery);