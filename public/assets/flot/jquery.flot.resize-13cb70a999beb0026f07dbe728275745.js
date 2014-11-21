/* Flot plugin for automatically redrawing plots as the placeholder resizes.

Copyright (c) 2007-2013 IOLA and Ole Laursen.
Licensed under the MIT license.

It works by listening for changes on the placeholder div (through the jQuery
resize event plugin) - if the size changes, it will redraw the plot.

There are no options. If you need to disable the plugin for some plots, you
can just fix the size of their placeholders.

*/
/* Inline dependency:
 * jQuery resize event - v1.1 - 3/14/2010
 * http://benalman.com/projects/jquery-resize-plugin/
 *
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
!function(t,e,n){function i(){for(var n=r.length-1;n>=0;n--){var s=t(r[n]);if(s[0]==e||s.is(":visible")){var p=s.width(),f=s.height(),g=s.data(c);!g||p===g.w&&f===g.h?a[u]=a[h]:(a[u]=a[d],s.trigger(l,[g.w=p,g.h=f]))}else g=s.data(c),g.w=0,g.h=0}null!==o&&(o=e.requestAnimationFrame(i))}var o,r=[],a=t.resize=t.extend(t.resize,{}),s="setTimeout",l="resize",c=l+"-special-event",u="delay",h="pendingDelay",d="activeDelay",p="throttleWindow";a[h]=250,a[d]=20,a[u]=a[h],a[p]=!0,t.event.special[l]={setup:function(){if(!a[p]&&this[s])return!1;var e=t(this);r.push(this),e.data(c,{w:e.width(),h:e.height()}),1===r.length&&(o=n,i())},teardown:function(){if(!a[p]&&this[s])return!1;for(var e=t(this),n=r.length-1;n>=0;n--)if(r[n]==this){r.splice(n,1);break}e.removeData(c),r.length||(cancelAnimationFrame(o),o=null)},add:function(e){function i(e,i,r){var a=t(this),s=a.data(c);s.w=i!==n?i:a.width(),s.h=r!==n?r:a.height(),o.apply(this,arguments)}if(!a[p]&&this[s])return!1;var o;return t.isFunction(e)?(o=e,i):(o=e.handler,void(e.handler=i))}},e.requestAnimationFrame||(e.requestAnimationFrame=function(){return e.webkitRequestAnimationFrame||e.mozRequestAnimationFrame||e.oRequestAnimationFrame||e.msRequestAnimationFrame||function(t){return e.setTimeout(t,a[u])}}()),e.cancelAnimationFrame||(e.cancelAnimationFrame=function(){return e.webkitCancelRequestAnimationFrame||e.mozCancelRequestAnimationFrame||e.oCancelRequestAnimationFrame||e.msCancelRequestAnimationFrame||clearTimeout}())}(jQuery,this),function(t){function e(t){function e(){var e=t.getPlaceholder();0!=e.width()&&0!=e.height()&&(t.resize(),t.setupGrid(),t.draw())}function n(t){t.getPlaceholder().resize(e)}function i(t){t.getPlaceholder().unbind("resize",e)}t.hooks.bindEvents.push(n),t.hooks.shutdown.push(i)}var n={};t.plot.plugins.push({init:e,options:n,name:"resize",version:"1.0"})}(jQuery);