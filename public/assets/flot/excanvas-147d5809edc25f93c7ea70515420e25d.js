// Copyright 2006 Google Inc.
document.createElement("canvas").getContext||!function(){function t(){return this.context_||(this.context_=new w(this))}function e(t,e){var n=I.call(arguments,2);return function(){return t.apply(e,n.concat(I.call(arguments)))}}function n(t){return String(t).replace(/&/g,"&amp;").replace(/"/g,"&quot;")}function i(t,e,n){t.namespaces[e]||t.namespaces.add(e,n,"#default#VML")}function o(t){if(i(t,"g_vml_","urn:schemas-microsoft-com:vml"),i(t,"g_o_","urn:schemas-microsoft-com:office:office"),!t.styleSheets.ex_canvas_){var e=t.createStyleSheet();e.owningElement.id="ex_canvas_",e.cssText="canvas{display:inline-block;overflow:hidden;text-align:left;width:300px;height:150px}"}}function r(t){var e=t.srcElement;switch(t.propertyName){case"width":e.getContext().clearRect(),e.style.width=e.attributes.width.nodeValue+"px",e.firstChild.style.width=e.clientWidth+"px";break;case"height":e.getContext().clearRect(),e.style.height=e.attributes.height.nodeValue+"px",e.firstChild.style.height=e.clientHeight+"px"}}function s(t){var e=t.srcElement;e.firstChild&&(e.firstChild.style.width=e.clientWidth+"px",e.firstChild.style.height=e.clientHeight+"px")}function a(){return[[1,0,0],[0,1,0],[0,0,1]]}function l(t,e){for(var n=a(),i=0;3>i;i++)for(var o=0;3>o;o++){for(var r=0,s=0;3>s;s++)r+=t[i][s]*e[s][o];n[i][o]=r}return n}function c(t,e){e.fillStyle=t.fillStyle,e.lineCap=t.lineCap,e.lineJoin=t.lineJoin,e.lineWidth=t.lineWidth,e.miterLimit=t.miterLimit,e.shadowBlur=t.shadowBlur,e.shadowColor=t.shadowColor,e.shadowOffsetX=t.shadowOffsetX,e.shadowOffsetY=t.shadowOffsetY,e.strokeStyle=t.strokeStyle,e.globalAlpha=t.globalAlpha,e.font=t.font,e.textAlign=t.textAlign,e.textBaseline=t.textBaseline,e.arcScaleX_=t.arcScaleX_,e.arcScaleY_=t.arcScaleY_,e.lineScale_=t.lineScale_}function u(t){var e=t.indexOf("(",3),n=t.indexOf(")",e+1),i=t.substring(e+1,n).split(",");return(4!=i.length||"a"!=t.charAt(3))&&(i[3]=1),i}function h(t){return parseFloat(t)/100}function d(t,e,n){return Math.min(n,Math.max(e,t))}function f(t){var e,n,i,o,r,s;if(o=parseFloat(t[0])/360%360,0>o&&o++,r=d(h(t[1]),0,1),s=d(h(t[2]),0,1),0==r)e=n=i=s;else{var a=.5>s?s*(1+r):s+r-s*r,l=2*s-a;e=p(l,a,o+1/3),n=p(l,a,o),i=p(l,a,o-1/3)}return"#"+q[Math.floor(255*e)]+q[Math.floor(255*n)]+q[Math.floor(255*i)]}function p(t,e,n){return 0>n&&n++,n>1&&n--,1>6*n?t+6*(e-t)*n:1>2*n?e:2>3*n?t+(e-t)*(2/3-n)*6:t}function g(t){if(t in Q)return Q[t];var e,n=1;if(t=String(t),"#"==t.charAt(0))e=t;else if(/^rgb/.test(t)){for(var i,o=u(t),e="#",r=0;3>r;r++)i=-1!=o[r].indexOf("%")?Math.floor(255*h(o[r])):+o[r],e+=q[d(i,0,255)];n=+o[3]}else if(/^hsl/.test(t)){var o=u(t);e=f(o),n=o[3]}else e=V[t]||t;return Q[t]={color:e,alpha:n}}function m(t){if(X[t])return X[t];var e=document.createElement("div"),n=e.style;try{n.font=t}catch(i){}return X[t]={style:n.fontStyle||U.style,variant:n.fontVariant||U.variant,weight:n.fontWeight||U.weight,size:n.fontSize||U.size,family:n.fontFamily||U.family}}function v(t,e){var n={};for(var i in t)n[i]=t[i];var o=parseFloat(e.currentStyle.fontSize),r=parseFloat(t.size);return n.size="number"==typeof t.size?t.size:-1!=t.size.indexOf("px")?r:-1!=t.size.indexOf("em")?o*r:-1!=t.size.indexOf("%")?o/100*r:-1!=t.size.indexOf("pt")?r/.75:o,n.size*=.981,n}function y(t){return t.style+" "+t.variant+" "+t.weight+" "+t.size+"px "+t.family}function b(t){return Y[t]||"square"}function w(t){this.m_=a(),this.mStack_=[],this.aStack_=[],this.currentPath_=[],this.strokeStyle="#000",this.fillStyle="#000",this.lineWidth=1,this.lineJoin="miter",this.lineCap="butt",this.miterLimit=1*R,this.globalAlpha=1,this.font="10px sans-serif",this.textAlign="left",this.textBaseline="alphabetic",this.canvas=t;var e="width:"+t.clientWidth+"px;height:"+t.clientHeight+"px;overflow:hidden;position:absolute",n=t.ownerDocument.createElement("div");n.style.cssText=e,t.appendChild(n);var i=n.cloneNode(!1);i.style.backgroundColor="red",i.style.filter="alpha(opacity=0)",t.appendChild(i),this.element_=n,this.arcScaleX_=1,this.arcScaleY_=1,this.lineScale_=1}function x(t,e,n,i){t.currentPath_.push({type:"bezierCurveTo",cp1x:e.x,cp1y:e.y,cp2x:n.x,cp2y:n.y,x:i.x,y:i.y}),t.currentX_=i.x,t.currentY_=i.y}function C(t,e){var n=g(t.strokeStyle),i=n.color,o=n.alpha*t.globalAlpha,r=t.lineScale_*t.lineWidth;1>r&&(o*=r),e.push("<g_vml_:stroke",' opacity="',o,'"',' joinstyle="',t.lineJoin,'"',' miterlimit="',t.miterLimit,'"',' endcap="',b(t.lineCap),'"',' weight="',r,'px"',' color="',i,'" />')}function $(t,e,n,i){var o=t.fillStyle,r=t.arcScaleX_,s=t.arcScaleY_,a=i.x-n.x,l=i.y-n.y;if(o instanceof S){var c=0,u={x:0,y:0},h=0,d=1;if("gradient"==o.type_){var f=o.x0_/r,p=o.y0_/s,m=o.x1_/r,v=o.y1_/s,y=k(t,f,p),b=k(t,m,v),w=b.x-y.x,x=b.y-y.y;c=180*Math.atan2(w,x)/Math.PI,0>c&&(c+=360),1e-6>c&&(c=0)}else{var y=k(t,o.x0_,o.y0_);u={x:(y.x-n.x)/a,y:(y.y-n.y)/l},a/=r*R,l/=s*R;var C=j.max(a,l);h=2*o.r0_/C,d=2*o.r1_/C-h}var $=o.colors_;$.sort(function(t,e){return t.offset-e.offset});for(var T=$.length,E=$[0].color,A=$[T-1].color,N=$[0].alpha*t.globalAlpha,_=$[T-1].alpha*t.globalAlpha,L=[],F=0;T>F;F++){var P=$[F];L.push(P.offset*d+h+" "+P.color)}e.push('<g_vml_:fill type="',o.type_,'"',' method="none" focus="100%"',' color="',E,'"',' color2="',A,'"',' colors="',L.join(","),'"',' opacity="',_,'"',' g_o_:opacity2="',N,'"',' angle="',c,'"',' focusposition="',u.x,",",u.y,'" />')}else if(o instanceof D){if(a&&l){var M=-n.x,O=-n.y;e.push("<g_vml_:fill",' position="',M/a*r*r,",",O/l*s*s,'"',' type="tile"',' src="',o.src_,'" />')}}else{var H=g(t.fillStyle),I=H.color,B=H.alpha*t.globalAlpha;e.push('<g_vml_:fill color="',I,'" opacity="',B,'" />')}}function k(t,e,n){var i=t.m_;return{x:R*(e*i[0][0]+n*i[1][0]+i[2][0])-H,y:R*(e*i[0][1]+n*i[1][1]+i[2][1])-H}}function T(t){return isFinite(t[0][0])&&isFinite(t[0][1])&&isFinite(t[1][0])&&isFinite(t[1][1])&&isFinite(t[2][0])&&isFinite(t[2][1])}function E(t,e,n){if(T(e)&&(t.m_=e,n)){var i=e[0][0]*e[1][1]-e[0][1]*e[1][0];t.lineScale_=O(M(i))}}function S(t){this.type_=t,this.x0_=0,this.y0_=0,this.r0_=0,this.x1_=0,this.y1_=0,this.r1_=0,this.colors_=[]}function D(t,e){switch(N(t),e){case"repeat":case null:case"":this.repetition_="repeat";break;case"repeat-x":case"repeat-y":case"no-repeat":this.repetition_=e;break;default:A("SYNTAX_ERR")}this.src_=t.src,this.width_=t.width,this.height_=t.height}function A(t){throw new _(t)}function N(t){t&&1==t.nodeType&&"IMG"==t.tagName||A("TYPE_MISMATCH_ERR"),"complete"!=t.readyState&&A("INVALID_STATE_ERR")}function _(t){this.code=this[t],this.message=t+": DOM Exception "+this.code}var j=Math,L=j.round,F=j.sin,P=j.cos,M=j.abs,O=j.sqrt,R=10,H=R/2,I=(+navigator.userAgent.match(/MSIE ([\d.]+)?/)[1],Array.prototype.slice);o(document);var B={init:function(t){var n=t||document;n.createElement("canvas"),n.attachEvent("onreadystatechange",e(this.init_,this,n))},init_:function(t){for(var e=t.getElementsByTagName("canvas"),n=0;n<e.length;n++)this.initElement(e[n])},initElement:function(e){if(!e.getContext){e.getContext=t,o(e.ownerDocument),e.innerHTML="",e.attachEvent("onpropertychange",r),e.attachEvent("onresize",s);var n=e.attributes;n.width&&n.width.specified?e.style.width=n.width.nodeValue+"px":e.width=e.clientWidth,n.height&&n.height.specified?e.style.height=n.height.nodeValue+"px":e.height=e.clientHeight}return e}};B.init();for(var q=[],W=0;16>W;W++)for(var z=0;16>z;z++)q[16*W+z]=W.toString(16)+z.toString(16);var V={aliceblue:"#F0F8FF",antiquewhite:"#FAEBD7",aquamarine:"#7FFFD4",azure:"#F0FFFF",beige:"#F5F5DC",bisque:"#FFE4C4",black:"#000000",blanchedalmond:"#FFEBCD",blueviolet:"#8A2BE2",brown:"#A52A2A",burlywood:"#DEB887",cadetblue:"#5F9EA0",chartreuse:"#7FFF00",chocolate:"#D2691E",coral:"#FF7F50",cornflowerblue:"#6495ED",cornsilk:"#FFF8DC",crimson:"#DC143C",cyan:"#00FFFF",darkblue:"#00008B",darkcyan:"#008B8B",darkgoldenrod:"#B8860B",darkgray:"#A9A9A9",darkgreen:"#006400",darkgrey:"#A9A9A9",darkkhaki:"#BDB76B",darkmagenta:"#8B008B",darkolivegreen:"#556B2F",darkorange:"#FF8C00",darkorchid:"#9932CC",darkred:"#8B0000",darksalmon:"#E9967A",darkseagreen:"#8FBC8F",darkslateblue:"#483D8B",darkslategray:"#2F4F4F",darkslategrey:"#2F4F4F",darkturquoise:"#00CED1",darkviolet:"#9400D3",deeppink:"#FF1493",deepskyblue:"#00BFFF",dimgray:"#696969",dimgrey:"#696969",dodgerblue:"#1E90FF",firebrick:"#B22222",floralwhite:"#FFFAF0",forestgreen:"#228B22",gainsboro:"#DCDCDC",ghostwhite:"#F8F8FF",gold:"#FFD700",goldenrod:"#DAA520",grey:"#808080",greenyellow:"#ADFF2F",honeydew:"#F0FFF0",hotpink:"#FF69B4",indianred:"#CD5C5C",indigo:"#4B0082",ivory:"#FFFFF0",khaki:"#F0E68C",lavender:"#E6E6FA",lavenderblush:"#FFF0F5",lawngreen:"#7CFC00",lemonchiffon:"#FFFACD",lightblue:"#ADD8E6",lightcoral:"#F08080",lightcyan:"#E0FFFF",lightgoldenrodyellow:"#FAFAD2",lightgreen:"#90EE90",lightgrey:"#D3D3D3",lightpink:"#FFB6C1",lightsalmon:"#FFA07A",lightseagreen:"#20B2AA",lightskyblue:"#87CEFA",lightslategray:"#778899",lightslategrey:"#778899",lightsteelblue:"#B0C4DE",lightyellow:"#FFFFE0",limegreen:"#32CD32",linen:"#FAF0E6",magenta:"#FF00FF",mediumaquamarine:"#66CDAA",mediumblue:"#0000CD",mediumorchid:"#BA55D3",mediumpurple:"#9370DB",mediumseagreen:"#3CB371",mediumslateblue:"#7B68EE",mediumspringgreen:"#00FA9A",mediumturquoise:"#48D1CC",mediumvioletred:"#C71585",midnightblue:"#191970",mintcream:"#F5FFFA",mistyrose:"#FFE4E1",moccasin:"#FFE4B5",navajowhite:"#FFDEAD",oldlace:"#FDF5E6",olivedrab:"#6B8E23",orange:"#FFA500",orangered:"#FF4500",orchid:"#DA70D6",palegoldenrod:"#EEE8AA",palegreen:"#98FB98",paleturquoise:"#AFEEEE",palevioletred:"#DB7093",papayawhip:"#FFEFD5",peachpuff:"#FFDAB9",peru:"#CD853F",pink:"#FFC0CB",plum:"#DDA0DD",powderblue:"#B0E0E6",rosybrown:"#BC8F8F",royalblue:"#4169E1",saddlebrown:"#8B4513",salmon:"#FA8072",sandybrown:"#F4A460",seagreen:"#2E8B57",seashell:"#FFF5EE",sienna:"#A0522D",skyblue:"#87CEEB",slateblue:"#6A5ACD",slategray:"#708090",slategrey:"#708090",snow:"#FFFAFA",springgreen:"#00FF7F",steelblue:"#4682B4",tan:"#D2B48C",thistle:"#D8BFD8",tomato:"#FF6347",turquoise:"#40E0D0",violet:"#EE82EE",wheat:"#F5DEB3",whitesmoke:"#F5F5F5",yellowgreen:"#9ACD32"},Q={},U={style:"normal",variant:"normal",weight:"normal",size:10,family:"sans-serif"},X={},Y={butt:"flat",round:"round"},G=w.prototype;G.clearRect=function(){this.textMeasureEl_&&(this.textMeasureEl_.removeNode(!0),this.textMeasureEl_=null),this.element_.innerHTML=""},G.beginPath=function(){this.currentPath_=[]},G.moveTo=function(t,e){var n=k(this,t,e);this.currentPath_.push({type:"moveTo",x:n.x,y:n.y}),this.currentX_=n.x,this.currentY_=n.y},G.lineTo=function(t,e){var n=k(this,t,e);this.currentPath_.push({type:"lineTo",x:n.x,y:n.y}),this.currentX_=n.x,this.currentY_=n.y},G.bezierCurveTo=function(t,e,n,i,o,r){var s=k(this,o,r),a=k(this,t,e),l=k(this,n,i);x(this,a,l,s)},G.quadraticCurveTo=function(t,e,n,i){var o=k(this,t,e),r=k(this,n,i),s={x:this.currentX_+2/3*(o.x-this.currentX_),y:this.currentY_+2/3*(o.y-this.currentY_)},a={x:s.x+(r.x-this.currentX_)/3,y:s.y+(r.y-this.currentY_)/3};x(this,s,a,r)},G.arc=function(t,e,n,i,o,r){n*=R;var s=r?"at":"wa",a=t+P(i)*n-H,l=e+F(i)*n-H,c=t+P(o)*n-H,u=e+F(o)*n-H;a!=c||r||(a+=.125);var h=k(this,t,e),d=k(this,a,l),f=k(this,c,u);this.currentPath_.push({type:s,x:h.x,y:h.y,radius:n,xStart:d.x,yStart:d.y,xEnd:f.x,yEnd:f.y})},G.rect=function(t,e,n,i){this.moveTo(t,e),this.lineTo(t+n,e),this.lineTo(t+n,e+i),this.lineTo(t,e+i),this.closePath()},G.strokeRect=function(t,e,n,i){var o=this.currentPath_;this.beginPath(),this.moveTo(t,e),this.lineTo(t+n,e),this.lineTo(t+n,e+i),this.lineTo(t,e+i),this.closePath(),this.stroke(),this.currentPath_=o},G.fillRect=function(t,e,n,i){var o=this.currentPath_;this.beginPath(),this.moveTo(t,e),this.lineTo(t+n,e),this.lineTo(t+n,e+i),this.lineTo(t,e+i),this.closePath(),this.fill(),this.currentPath_=o},G.createLinearGradient=function(t,e,n,i){var o=new S("gradient");return o.x0_=t,o.y0_=e,o.x1_=n,o.y1_=i,o},G.createRadialGradient=function(t,e,n,i,o,r){var s=new S("gradientradial");return s.x0_=t,s.y0_=e,s.r0_=n,s.x1_=i,s.y1_=o,s.r1_=r,s},G.drawImage=function(t){var e,n,i,o,r,s,a,l,c=t.runtimeStyle.width,u=t.runtimeStyle.height;t.runtimeStyle.width="auto",t.runtimeStyle.height="auto";var h=t.width,d=t.height;if(t.runtimeStyle.width=c,t.runtimeStyle.height=u,3==arguments.length)e=arguments[1],n=arguments[2],r=s=0,a=i=h,l=o=d;else if(5==arguments.length)e=arguments[1],n=arguments[2],i=arguments[3],o=arguments[4],r=s=0,a=h,l=d;else{if(9!=arguments.length)throw Error("Invalid number of arguments");r=arguments[1],s=arguments[2],a=arguments[3],l=arguments[4],e=arguments[5],n=arguments[6],i=arguments[7],o=arguments[8]}var f=k(this,e,n),p=[],g=10,m=10;if(p.push(" <g_vml_:group",' coordsize="',R*g,",",R*m,'"',' coordorigin="0,0"',' style="width:',g,"px;height:",m,"px;position:absolute;"),1!=this.m_[0][0]||this.m_[0][1]||1!=this.m_[1][1]||this.m_[1][0]){var v=[];v.push("M11=",this.m_[0][0],",","M12=",this.m_[1][0],",","M21=",this.m_[0][1],",","M22=",this.m_[1][1],",","Dx=",L(f.x/R),",","Dy=",L(f.y/R),"");var y=f,b=k(this,e+i,n),w=k(this,e,n+o),x=k(this,e+i,n+o);y.x=j.max(y.x,b.x,w.x,x.x),y.y=j.max(y.y,b.y,w.y,x.y),p.push("padding:0 ",L(y.x/R),"px ",L(y.y/R),"px 0;filter:progid:DXImageTransform.Microsoft.Matrix(",v.join(""),", sizingmethod='clip');")}else p.push("top:",L(f.y/R),"px;left:",L(f.x/R),"px;");p.push(' ">','<g_vml_:image src="',t.src,'"',' style="width:',R*i,"px;"," height:",R*o,'px"',' cropleft="',r/h,'"',' croptop="',s/d,'"',' cropright="',(h-r-a)/h,'"',' cropbottom="',(d-s-l)/d,'"'," />","</g_vml_:group>"),this.element_.insertAdjacentHTML("BeforeEnd",p.join(""))},G.stroke=function(t){for(var e=10,n=10,i=5e3,o={x:null,y:null},r={x:null,y:null},s=0;s<this.currentPath_.length;s+=i){var a=[];a.push("<g_vml_:shape",' filled="',!!t,'"',' style="position:absolute;width:',e,"px;height:",n,'px;"',' coordorigin="0,0"',' coordsize="',R*e,",",R*n,'"',' stroked="',!t,'"',' path="');for(var l=s;l<Math.min(s+i,this.currentPath_.length);l++){l%i==0&&l>0&&a.push(" m ",L(this.currentPath_[l-1].x),",",L(this.currentPath_[l-1].y));var c,u=this.currentPath_[l];switch(u.type){case"moveTo":c=u,a.push(" m ",L(u.x),",",L(u.y));break;case"lineTo":a.push(" l ",L(u.x),",",L(u.y));break;case"close":a.push(" x "),u=null;break;case"bezierCurveTo":a.push(" c ",L(u.cp1x),",",L(u.cp1y),",",L(u.cp2x),",",L(u.cp2y),",",L(u.x),",",L(u.y));break;case"at":case"wa":a.push(" ",u.type," ",L(u.x-this.arcScaleX_*u.radius),",",L(u.y-this.arcScaleY_*u.radius)," ",L(u.x+this.arcScaleX_*u.radius),",",L(u.y+this.arcScaleY_*u.radius)," ",L(u.xStart),",",L(u.yStart)," ",L(u.xEnd),",",L(u.yEnd))}u&&((null==o.x||u.x<o.x)&&(o.x=u.x),(null==r.x||u.x>r.x)&&(r.x=u.x),(null==o.y||u.y<o.y)&&(o.y=u.y),(null==r.y||u.y>r.y)&&(r.y=u.y))}a.push(' ">'),t?$(this,a,o,r):C(this,a),a.push("</g_vml_:shape>"),this.element_.insertAdjacentHTML("beforeEnd",a.join(""))}},G.fill=function(){this.stroke(!0)},G.closePath=function(){this.currentPath_.push({type:"close"})},G.save=function(){var t={};c(this,t),this.aStack_.push(t),this.mStack_.push(this.m_),this.m_=l(a(),this.m_)},G.restore=function(){this.aStack_.length&&(c(this.aStack_.pop(),this),this.m_=this.mStack_.pop())},G.translate=function(t,e){var n=[[1,0,0],[0,1,0],[t,e,1]];E(this,l(n,this.m_),!1)},G.rotate=function(t){var e=P(t),n=F(t),i=[[e,n,0],[-n,e,0],[0,0,1]];E(this,l(i,this.m_),!1)},G.scale=function(t,e){this.arcScaleX_*=t,this.arcScaleY_*=e;var n=[[t,0,0],[0,e,0],[0,0,1]];E(this,l(n,this.m_),!0)},G.transform=function(t,e,n,i,o,r){var s=[[t,e,0],[n,i,0],[o,r,1]];E(this,l(s,this.m_),!0)},G.setTransform=function(t,e,n,i,o,r){var s=[[t,e,0],[n,i,0],[o,r,1]];E(this,s,!0)},G.drawText_=function(t,e,i,o,r){var s=this.m_,a=1e3,l=0,c=a,u={x:0,y:0},h=[],d=v(m(this.font),this.element_),f=y(d),p=this.element_.currentStyle,g=this.textAlign.toLowerCase();switch(g){case"left":case"center":case"right":break;case"end":g="ltr"==p.direction?"right":"left";break;case"start":g="rtl"==p.direction?"right":"left";break;default:g="left"}switch(this.textBaseline){case"hanging":case"top":u.y=d.size/1.75;break;case"middle":break;default:case null:case"alphabetic":case"ideographic":case"bottom":u.y=-d.size/2.25}switch(g){case"right":l=a,c=.05;break;case"center":l=c=a/2}var b=k(this,e+u.x,i+u.y);h.push('<g_vml_:line from="',-l,' 0" to="',c,' 0.05" ',' coordsize="100 100" coordorigin="0 0"',' filled="',!r,'" stroked="',!!r,'" style="position:absolute;width:1px;height:1px;">'),r?C(this,h):$(this,h,{x:-l,y:0},{x:c,y:d.size});var w=s[0][0].toFixed(3)+","+s[1][0].toFixed(3)+","+s[0][1].toFixed(3)+","+s[1][1].toFixed(3)+",0,0",x=L(b.x/R)+","+L(b.y/R);h.push('<g_vml_:skew on="t" matrix="',w,'" ',' offset="',x,'" origin="',l,' 0" />','<g_vml_:path textpathok="true" />','<g_vml_:textpath on="true" string="',n(t),'" style="v-text-align:',g,";font:",n(f),'" /></g_vml_:line>'),this.element_.insertAdjacentHTML("beforeEnd",h.join(""))},G.fillText=function(t,e,n,i){this.drawText_(t,e,n,i,!1)},G.strokeText=function(t,e,n,i){this.drawText_(t,e,n,i,!0)},G.measureText=function(t){if(!this.textMeasureEl_){var e='<span style="position:absolute;top:-20000px;left:0;padding:0;margin:0;border:none;white-space:pre;"></span>';this.element_.insertAdjacentHTML("beforeEnd",e),this.textMeasureEl_=this.element_.lastChild}var n=this.element_.ownerDocument;return this.textMeasureEl_.innerHTML="",this.textMeasureEl_.style.font=this.font,this.textMeasureEl_.appendChild(n.createTextNode(t)),{width:this.textMeasureEl_.offsetWidth}},G.clip=function(){},G.arcTo=function(){},G.createPattern=function(t,e){return new D(t,e)},S.prototype.addColorStop=function(t,e){e=g(e),this.colors_.push({offset:t,color:e.color,alpha:e.alpha})};var K=_.prototype=new Error;K.INDEX_SIZE_ERR=1,K.DOMSTRING_SIZE_ERR=2,K.HIERARCHY_REQUEST_ERR=3,K.WRONG_DOCUMENT_ERR=4,K.INVALID_CHARACTER_ERR=5,K.NO_DATA_ALLOWED_ERR=6,K.NO_MODIFICATION_ALLOWED_ERR=7,K.NOT_FOUND_ERR=8,K.NOT_SUPPORTED_ERR=9,K.INUSE_ATTRIBUTE_ERR=10,K.INVALID_STATE_ERR=11,K.SYNTAX_ERR=12,K.INVALID_MODIFICATION_ERR=13,K.NAMESPACE_ERR=14,K.INVALID_ACCESS_ERR=15,K.VALIDATION_ERR=16,K.TYPE_MISMATCH_ERR=17,G_vmlCanvasManager=B,CanvasRenderingContext2D=w,CanvasGradient=S,CanvasPattern=D,DOMException=_}();