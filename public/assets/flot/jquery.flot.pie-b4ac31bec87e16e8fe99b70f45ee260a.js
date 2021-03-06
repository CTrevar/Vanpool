/* Flot plugin for rendering pie charts.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

The plugin assumes that each series has a single data value, and that each
value is a positive integer or zero.  Negative numbers don't make sense for a
pie chart, and have unpredictable results.  The values do NOT need to be
passed in as percentages; the plugin will calculate the total and per-slice
percentages internally.

* Created by Brian Medendorp

* Updated with contributions from btburnett3, Anthony Aragues and Xavi Ivars

The plugin supports these options:

	series: {
		pie: {
			show: true/false
			radius: 0-1 for percentage of fullsize, or a specified pixel length, or 'auto'
			innerRadius: 0-1 for percentage of fullsize or a specified pixel length, for creating a donut effect
			startAngle: 0-2 factor of PI used for starting angle (in radians) i.e 3/2 starts at the top, 0 and 2 have the same result
			tilt: 0-1 for percentage to tilt the pie, where 1 is no tilt, and 0 is completely flat (nothing will show)
			offset: {
				top: integer value to move the pie up or down
				left: integer value to move the pie left or right, or 'auto'
			},
			stroke: {
				color: any hexidecimal color value (other formats may or may not work, so best to stick with something like '#FFF')
				width: integer pixel width of the stroke
			},
			label: {
				show: true/false, or 'auto'
				formatter:  a user-defined function that modifies the text/style of the label text
				radius: 0-1 for percentage of fullsize, or a specified pixel length
				background: {
					color: any hexidecimal color value (other formats may or may not work, so best to stick with something like '#000')
					opacity: 0-1
				},
				threshold: 0-1 for the percentage value at which to hide labels (if they're too small)
			},
			combine: {
				threshold: 0-1 for the percentage value at which to combine slices (if they're too small)
				color: any hexidecimal color value (other formats may or may not work, so best to stick with something like '#CCC'), if null, the plugin will automatically use the color of the first slice to be combined
				label: any text value of what the combined slice should be labeled
			}
			highlight: {
				opacity: 0-1
			}
		}
	}

More detail and specific examples can be found in the included HTML file.

*/
!function(t){function e(e){function o(e){k||(k=!0,v=e.getCanvas(),y=t(v).parent(),x=e.getOptions(),e.setData(r(e.getData())))}function r(e){for(var n=0,i=0,o=0,r=x.series.pie.combine.color,a=[],s=0;s<e.length;++s){var l=e[s].data;t.isArray(l)&&1==l.length&&(l=l[0]),t.isArray(l)?l[1]=!isNaN(parseFloat(l[1]))&&isFinite(l[1])?+l[1]:0:l=!isNaN(parseFloat(l))&&isFinite(l)?[1,+l]:[1,0],e[s].data=[l]}for(var s=0;s<e.length;++s)n+=e[s].data[0][1];for(var s=0;s<e.length;++s){var l=e[s].data[0][1];l/n<=x.series.pie.combine.threshold&&(i+=l,o++,r||(r=e[s].color))}for(var s=0;s<e.length;++s){var l=e[s].data[0][1];(2>o||l/n>x.series.pie.combine.threshold)&&a.push({data:[[1,l]],color:e[s].color,label:e[s].label,angle:l*Math.PI*2/n,percent:l/(n/100)})}return o>1&&a.push({data:[[1,i]],color:r,label:x.series.pie.combine.label,angle:i*Math.PI*2/n,percent:i/(n/100)}),a}function a(e,o){function r(){T.clearRect(0,0,c,u),y.children().filter(".pieLabel, .pieLabelBackground").remove()}function a(){var t=x.series.pie.shadow.left,e=x.series.pie.shadow.top,n=10,i=x.series.pie.shadow.alpha,o=x.series.pie.radius>1?x.series.pie.radius:b*x.series.pie.radius;if(!(o>=c/2-t||o*x.series.pie.tilt>=u/2-e||n>=o)){T.save(),T.translate(t,e),T.globalAlpha=i,T.fillStyle="#000",T.translate(w,C),T.scale(1,x.series.pie.tilt);for(var r=1;n>=r;r++)T.beginPath(),T.arc(0,0,o,0,2*Math.PI,!1),T.fill(),o-=r;T.restore()}}function l(){function e(t,e,n){0>=t||isNaN(t)||(n?T.fillStyle=e:(T.strokeStyle=e,T.lineJoin="round"),T.beginPath(),Math.abs(t-2*Math.PI)>1e-9&&T.moveTo(0,0),T.arc(0,0,o,r,r+t/2,!1),T.arc(0,0,o,r+t/2,r+t,!1),T.closePath(),r+=t,n?T.fill():T.stroke())}function n(){function e(e,n,i){if(0==e.data[0][1])return!0;var r,a=x.legend.labelFormatter,s=x.series.pie.label.formatter;r=a?a(e.label,e):e.label,s&&(r=s(r,e));var l=(n+e.angle+n)/2,h=w+Math.round(Math.cos(l)*o),d=C+Math.round(Math.sin(l)*o)*x.series.pie.tilt,f="<span class='pieLabel' id='pieLabel"+i+"' style='position:absolute;top:"+d+"px;left:"+h+"px;'>"+r+"</span>";y.append(f);var p=y.children("#pieLabel"+i),g=d-p.height()/2,m=h-p.width()/2;if(p.css("top",g),p.css("left",m),0-g>0||0-m>0||u-(g+p.height())<0||c-(m+p.width())<0)return!1;if(0!=x.series.pie.label.background.opacity){var v=x.series.pie.label.background.color;null==v&&(v=e.color);var b="top:"+g+"px;left:"+m+"px;";t("<div class='pieLabelBackground' style='position:absolute;width:"+p.width()+"px;height:"+p.height()+"px;"+b+"background-color:"+v+";'></div>").css("opacity",x.series.pie.label.background.opacity).insertBefore(p)}return!0}for(var n=i,o=x.series.pie.label.radius>1?x.series.pie.label.radius:b*x.series.pie.label.radius,r=0;r<d.length;++r){if(d[r].percent>=100*x.series.pie.label.threshold&&!e(d[r],n,r))return!1;n+=d[r].angle}return!0}var i=Math.PI*x.series.pie.startAngle,o=x.series.pie.radius>1?x.series.pie.radius:b*x.series.pie.radius;T.save(),T.translate(w,C),T.scale(1,x.series.pie.tilt),T.save();for(var r=i,a=0;a<d.length;++a)d[a].startAngle=r,e(d[a].angle,d[a].color,!0);if(T.restore(),x.series.pie.stroke.width>0){T.save(),T.lineWidth=x.series.pie.stroke.width,r=i;for(var a=0;a<d.length;++a)e(d[a].angle,x.series.pie.stroke.color,!1);T.restore()}return s(T),T.restore(),x.series.pie.label.show?n():!0}if(y){var c=e.getPlaceholder().width(),u=e.getPlaceholder().height(),h=y.children().filter(".legend").children().width()||0;T=o,k=!1,b=Math.min(c,u/x.series.pie.tilt)/2,C=u/2+x.series.pie.offset.top,w=c/2,"auto"==x.series.pie.offset.left?(x.legend.position.match("w")?w+=h/2:w-=h/2,b>w?w=b:w>c-b&&(w=c-b)):w+=x.series.pie.offset.left;var d=e.getData(),f=0;do f>0&&(b*=i),f+=1,r(),x.series.pie.tilt<=.8&&a();while(!l()&&n>f);f>=n&&(r(),y.prepend("<div class='error'>Could not draw pie with labels contained inside canvas</div>")),e.setSeries&&e.insertLegend&&(e.setSeries(d),e.insertLegend())}}function s(t){if(x.series.pie.innerRadius>0){t.save();var e=x.series.pie.innerRadius>1?x.series.pie.innerRadius:b*x.series.pie.innerRadius;t.globalCompositeOperation="destination-out",t.beginPath(),t.fillStyle=x.series.pie.stroke.color,t.arc(0,0,e,0,2*Math.PI,!1),t.fill(),t.closePath(),t.restore(),t.save(),t.beginPath(),t.strokeStyle=x.series.pie.stroke.color,t.arc(0,0,e,0,2*Math.PI,!1),t.stroke(),t.closePath(),t.restore()}}function l(t,e){for(var n=!1,i=-1,o=t.length,r=o-1;++i<o;r=i)(t[i][1]<=e[1]&&e[1]<t[r][1]||t[r][1]<=e[1]&&e[1]<t[i][1])&&e[0]<(t[r][0]-t[i][0])*(e[1]-t[i][1])/(t[r][1]-t[i][1])+t[i][0]&&(n=!n);return n}function c(t,n){for(var i,o,r=e.getData(),a=e.getOptions(),s=a.series.pie.radius>1?a.series.pie.radius:b*a.series.pie.radius,c=0;c<r.length;++c){var u=r[c];if(u.pie.show){if(T.save(),T.beginPath(),T.moveTo(0,0),T.arc(0,0,s,u.startAngle,u.startAngle+u.angle/2,!1),T.arc(0,0,s,u.startAngle+u.angle/2,u.startAngle+u.angle,!1),T.closePath(),i=t-w,o=n-C,T.isPointInPath){if(T.isPointInPath(t-w,n-C))return T.restore(),{datapoint:[u.percent,u.data],dataIndex:0,series:u,seriesIndex:c}}else{var h=s*Math.cos(u.startAngle),d=s*Math.sin(u.startAngle),f=s*Math.cos(u.startAngle+u.angle/4),p=s*Math.sin(u.startAngle+u.angle/4),g=s*Math.cos(u.startAngle+u.angle/2),m=s*Math.sin(u.startAngle+u.angle/2),v=s*Math.cos(u.startAngle+u.angle/1.5),y=s*Math.sin(u.startAngle+u.angle/1.5),x=s*Math.cos(u.startAngle+u.angle),k=s*Math.sin(u.startAngle+u.angle),$=[[0,0],[h,d],[f,p],[g,m],[v,y],[x,k]],S=[i,o];if(l($,S))return T.restore(),{datapoint:[u.percent,u.data],dataIndex:0,series:u,seriesIndex:c}}T.restore()}}return null}function u(t){d("plothover",t)}function h(t){d("plotclick",t)}function d(t,n){var i=e.offset(),o=parseInt(n.pageX-i.left),r=parseInt(n.pageY-i.top),a=c(o,r);if(x.grid.autoHighlight)for(var s=0;s<$.length;++s){var l=$[s];l.auto!=t||a&&l.series==a.series||p(l.series)}a&&f(a.series,t);var u={pageX:n.pageX,pageY:n.pageY};y.trigger(t,[u,a])}function f(t,n){var i=g(t);-1==i?($.push({series:t,auto:n}),e.triggerRedrawOverlay()):n||($[i].auto=!1)}function p(t){null==t&&($=[],e.triggerRedrawOverlay());var n=g(t);-1!=n&&($.splice(n,1),e.triggerRedrawOverlay())}function g(t){for(var e=0;e<$.length;++e){var n=$[e];if(n.series==t)return e}return-1}function m(t,e){function n(t){t.angle<=0||isNaN(t.angle)||(e.fillStyle="rgba(255, 255, 255, "+i.series.pie.highlight.opacity+")",e.beginPath(),Math.abs(t.angle-2*Math.PI)>1e-9&&e.moveTo(0,0),e.arc(0,0,o,t.startAngle,t.startAngle+t.angle/2,!1),e.arc(0,0,o,t.startAngle+t.angle/2,t.startAngle+t.angle,!1),e.closePath(),e.fill())}var i=t.getOptions(),o=i.series.pie.radius>1?i.series.pie.radius:b*i.series.pie.radius;e.save(),e.translate(w,C),e.scale(1,i.series.pie.tilt);for(var r=0;r<$.length;++r)n($[r].series);s(e),e.restore()}var v=null,y=null,x=null,b=null,w=null,C=null,k=!1,T=null,$=[];e.hooks.processOptions.push(function(t,e){e.series.pie.show&&(e.grid.show=!1,"auto"==e.series.pie.label.show&&(e.series.pie.label.show=e.legend.show?!1:!0),"auto"==e.series.pie.radius&&(e.series.pie.radius=e.series.pie.label.show?.75:1),e.series.pie.tilt>1?e.series.pie.tilt=1:e.series.pie.tilt<0&&(e.series.pie.tilt=0))}),e.hooks.bindEvents.push(function(t,e){var n=t.getOptions();n.series.pie.show&&(n.grid.hoverable&&e.unbind("mousemove").mousemove(u),n.grid.clickable&&e.unbind("click").click(h))}),e.hooks.processDatapoints.push(function(t,e,n,i){var r=t.getOptions();r.series.pie.show&&o(t,e,n,i)}),e.hooks.drawOverlay.push(function(t,e){var n=t.getOptions();n.series.pie.show&&m(t,e)}),e.hooks.draw.push(function(t,e){var n=t.getOptions();n.series.pie.show&&a(t,e)})}var n=10,i=.95,o={series:{pie:{show:!1,radius:"auto",innerRadius:0,startAngle:1.5,tilt:1,shadow:{left:5,top:15,alpha:.02},offset:{top:0,left:"auto"},stroke:{color:"#fff",width:1},label:{show:"auto",formatter:function(t,e){return"<div style='font-size:x-small;text-align:center;padding:2px;color:"+e.color+";'>"+t+"<br/>"+Math.round(e.percent)+"%</div>"},radius:1,background:{color:null,opacity:0},threshold:0},combine:{threshold:-1,color:null,label:"Other"},highlight:{opacity:.5}}}};t.plot.plugins.push({init:e,options:o,name:"pie",version:"1.1"})}(jQuery);