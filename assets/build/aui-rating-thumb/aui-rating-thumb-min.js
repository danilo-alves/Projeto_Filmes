YUI.add("aui-rating-thumb",function(e,t){var n="cssClasses",r="down",i="element",s="elements",o="icon",u="Label",a="off",f="on",l="rating",c="thumb",h="ThumbRating",p="thumbs",d="up",v=e.getClassName,m=v(o,p,r),g=v(o,p,d),y=v(l,a),b=v(l,f),w=e.Component.create({NAME:h,ATTRS:{cssClasses:{value:{down:m,element:y,hover:b,off:y,on:b,up:g}},size:{value:2,readOnly:!0}},EXTENDS:e.Rating,prototype:{renderUI:function(){var e=this,t=e.get(n);w.superclass.renderUI.apply(this,arguments);var r=e.get(s);r.addClass(t.off),r.item(0).addClass(t.up),r.item(1).addClass(t.down)},fillTo:function(e,t){var r=this,i=r.get(n);this.clearSelection();if(e>=0){var o=this.get(s).item(e);o.addClass(i.on),o.removeClass(i.off)}},_syncElements:function(){}}});e.ThumbRating=w},"2.0.0pr5",{requires:["aui-rating-base"]});
