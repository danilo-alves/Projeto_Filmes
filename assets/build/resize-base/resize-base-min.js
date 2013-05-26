YUI.add("resize-base",function(e,t){function Lt(){Lt.superclass.constructor.apply(this,arguments)}var n=e.Lang,r=n.isArray,i=n.isBoolean,s=n.isNumber,o=n.isString,u=e.Array,a=n.trim,f=u.indexOf,l=",",c=".",h="",p="{handle}",d=" ",v="active",m="activeHandle",g="activeHandleNode",y="all",b="autoHide",w="border",E="bottom",S="className",x="color",T="defMinHeight",N="defMinWidth",C="handle",k="handles",L="handlesWrapper",A="hidden",O="inner",M="left",_="margin",D="node",P="nodeName",H="none",B="offsetHeight",j="offsetWidth",F="padding",I="parentNode",q="position",R="relative",U="resize",z="resizing",W="right",X="static",V="style",$="top",J="width",K="wrap",Q="wrapper",G="wrapTypes",Y="resize:mouseUp",Z="resize:resize",et="resize:align",tt="resize:end",nt="resize:start",rt="t",it="tr",st="r",ot="br",ut="b",at="bl",ft="l",lt="tl",ct=function(){return Array.prototype.slice.call(arguments).join(d)},ht=function(e){return Math.round(parseFloat(e))||0},pt=function(e,t){return e.getComputedStyle(t)},dt=function(e){return C+e.toUpperCase()},vt=function(t){return t instanceof e.Node},mt=e.cached(function(e){return e.substring(0,1).toUpperCase()+e.substring(1)}),gt=e.cached(function(){var e=[],t=u(arguments,0,!0);return u.each(t,function(t,n){n>0&&(t=mt(t)),e.push(t)}),e.join(h)}),yt=e.ClassNameManager.getClassName,bt=yt(U),wt=yt(U,C),Et=yt(U,C,v),St=yt(U,C,O),xt=yt(U,C,O,p),Tt=yt(U,C,p),Nt=yt(U,A,k),Ct=yt(U,k,Q),kt=yt(U,Q);e.mix(Lt,{NAME:U,ATTRS:{activeHandle:{value:null,validator:function(t){return e.Lang.isString(t)||e.Lang.isNull(t)}},activeHandleNode:{value:null,validator:vt},autoHide:{value:!1,validator:i},defMinHeight:{value:15,validator:s},defMinWidth:{value:15,validator:s},handles:{setter:"_setHandles",value:y},handlesWrapper:{readOnly:!0,setter:e.one,valueFn:"_valueHandlesWrapper"},node:{setter:e.one},resizing:{value:!1,validator:i},wrap:{setter:"_setWrap",value:!1,validator:i},wrapTypes:{readOnly:!0,value:/^canvas|textarea|input|select|button|img|iframe|table|embed$/i},wrapper:{readOnly:!0,valueFn:"_valueWrapper",writeOnce:!0}},RULES:{b:function(e,t,n){var r=e.info,i=e.originalInfo;r.offsetHeight=i.offsetHeight+n},l:function(e,t){var n=e.info,r=e.originalInfo;n.left=r.left+t,n.offsetWidth=r.offsetWidth-t},r:function(e,t){var n=e.info,r=e.originalInfo;n.offsetWidth=r.offsetWidth+t},t:function(e,t,n){var r=e.info,i=e.originalInfo;r.top=i.top+n,r.offsetHeight=i.offsetHeight-n},tr:function(){this.t.apply(this,arguments),this.r.apply(this,arguments)},bl:function(){this.b.apply(this,arguments),this.l.apply(this,arguments)},br:function(){this.b.apply(this,arguments),this.r.apply(this,arguments)},tl:function(){this.t.apply(this,arguments),this.l.apply(this,arguments)}},capitalize:gt}),e.Resize=e.extend(Lt,e.Base,{ALL_HANDLES:[rt,it,st,ot,ut,at,ft,lt],REGEX_CHANGE_HEIGHT:/^(t|tr|b|bl|br|tl)$/i,REGEX_CHANGE_LEFT:/^(tl|l|bl)$/i,REGEX_CHANGE_TOP:/^(tl|t|tr)$/i,REGEX_CHANGE_WIDTH:/^(bl|br|l|r|tl|tr)$/i,HANDLES_WRAP_TEMPLATE:'<div class="'+Ct+'"></div>',WRAP_TEMPLATE:'<div class="'+kt+'"></div>',HANDLE_TEMPLATE:'<div class="'+ct(wt,Tt)+'">'+'<div class="'+ct(St,xt)+'">&nbsp;</div>'+"</div>",totalHSurrounding:0,totalVSurrounding:0,nodeSurrounding:null,wrapperSurrounding:null,changeHeightHandles:!1,changeLeftHandles:!1,changeTopHandles:!1,changeWidthHandles:!1,delegate:null,info:null,lastInfo:null,originalInfo:null,initializer:function(){this._eventHandles=[],this.renderer()},renderUI:function(){var e=this;e._renderHandles()},bindUI:function(){var e=this;e._createEvents(),e._bindDD(),e._bindHandle()},syncUI:function(){var e=this;this.get(D).addClass(bt),e._setHideHandlesUI(e.get(b))},destructor:function(){var t=this,n=t.get(D),r=t.get(Q),i=r.get(I);e.each(t._eventHandles,function(e){e.detach()}),t._eventHandles.length=0,t.eachHandle(function(e){t.delegate.dd.destroy(),e.remove(!0)}),t.delegate.destroy(),t.get(K)&&(t._copyStyles(r,n),i&&i.insertBefore(n,r),r.remove(!0)),n.removeClass(bt),n.removeClass(Nt)},renderer:function(){this.renderUI(),this.bindUI(),this.syncUI()},eachHandle:function(t){var n=this;e.each(n.get(k),function(e,r){var i=n.get(dt(e));t.apply(n,[i,e,r])})},_bindDD:function(){var t=this;t.delegate=new e.DD.Delegate({bubbleTargets:t,container:t.get(L),dragConfig:{clickPixelThresh:0,clickTimeThresh:0,useShim:!0,move:!1},nodes:c+wt,target:!1}),t._eventHandles.push(t.on("drag:drag",t._handleResizeEvent),t.on("drag:dropmiss",t._handleMouseUpEvent),t.on("drag:end",t._handleResizeEndEvent),t.on("drag:start",t._handleResizeStartEvent))},_bindHandle:function(){var t=this,n=t.get(Q);t._eventHandles.push(n.on("mouseenter",e.bind(t._onWrapperMouseEnter,t)),n.on("mouseleave",e.bind(t._onWrapperMouseLeave,t)),n.delegate("mouseenter",e.bind(t._onHandleMouseEnter,t),c+wt),n.delegate("mouseleave",e.bind(t._onHandleMouseLeave,t),c+wt))},_createEvents:function(){var e=this,t=function(t,n){e.publish(t,{defaultFn:n,queuable:!1,emitFacade:!0,bubbles:!0,prefix:U})};t(nt,this._defResizeStartFn),t(Z,this._defResizeFn),t(et,this._defResizeAlignFn),t(tt,this._defResizeEndFn),t(Y,this._defMouseUpFn)},_renderHandles:function(){var e=this,t=e.get(Q),n=e.get(L);e.eachHandle(function(e){n.append(e)}),t.append(n)},_buildHandle:function(t){var n=this;return e.Node.create(e.Lang.sub(n.HANDLE_TEMPLATE,{handle:t}))},_calcResize:function(){var t=this,n=t.handle,r=t.info,i=t.originalInfo,s=r.actXY[0]-i.actXY[0],o=r.actXY[1]-i.actXY[1];n&&e.Resize.RULES[n]&&e.Resize.RULES[n](t,s,o)},_checkSize:function(e,t){var n=this,r=n.info,i=n.originalInfo,s=e===B?$:M;r[e]=t;if(s===M&&n.changeLeftHandles||s===$&&n.changeTopHandles)r[s]=i[s]+i[e]-t},_copyStyles:function(t,n){var r=t.getStyle(q).toLowerCase(),i=this._getBoxSurroundingInfo(t),s;r===X&&(r=R),s={position:r,left:pt(t,M),top:pt(t,$)},e.mix(s,i.margin),e.mix(s,i.border),n.setStyles(s),t.setStyles({border:0,margin:0}),n.sizeTo(t.get(j)+i.totalHBorder,t.get(B)+i.totalVBorder)},_extractHandleName:e.cached(function(e){var t=e.get(S),n=t.match(new RegExp(yt(U,C,"(\\w{1,2})\\b")));return n?n[1
]:null}),_getInfo:function(e,t){var n=[0,0],r=t.dragEvent.target,i=e.getXY(),s=i[0],o=i[1],u=e.get(B),a=e.get(j);return t&&(n=r.actXY.length?r.actXY:r.lastXY),{actXY:n,bottom:o+u,left:s,offsetHeight:u,offsetWidth:a,right:s+a,top:o}},_getBoxSurroundingInfo:function(t){var n={padding:{},margin:{},border:{}};return vt(t)&&e.each([$,W,E,M],function(e){var r=gt(F,e),i=gt(_,e),s=gt(w,e,J),o=gt(w,e,x),u=gt(w,e,V);n.border[o]=pt(t,o),n.border[u]=pt(t,u),n.border[s]=pt(t,s),n.margin[i]=pt(t,i),n.padding[r]=pt(t,r)}),n.totalHBorder=ht(n.border.borderLeftWidth)+ht(n.border.borderRightWidth),n.totalHPadding=ht(n.padding.paddingLeft)+ht(n.padding.paddingRight),n.totalVBorder=ht(n.border.borderBottomWidth)+ht(n.border.borderTopWidth),n.totalVPadding=ht(n.padding.paddingBottom)+ht(n.padding.paddingTop),n},_syncUI:function(){var t=this,n=t.info,r=t.wrapperSurrounding,i=t.get(Q),s=t.get(D);i.sizeTo(n.offsetWidth,n.offsetHeight),(t.changeLeftHandles||t.changeTopHandles)&&i.setXY([n.left,n.top]),i.compareTo(s)||s.sizeTo(n.offsetWidth-r.totalHBorder,n.offsetHeight-r.totalVBorder),e.UA.webkit&&s.setStyle(U,H)},_updateChangeHandleInfo:function(e){var t=this;t.changeHeightHandles=t.REGEX_CHANGE_HEIGHT.test(e),t.changeLeftHandles=t.REGEX_CHANGE_LEFT.test(e),t.changeTopHandles=t.REGEX_CHANGE_TOP.test(e),t.changeWidthHandles=t.REGEX_CHANGE_WIDTH.test(e)},_updateInfo:function(e){var t=this;t.info=t._getInfo(t.get(Q),e)},_updateSurroundingInfo:function(){var e=this,t=e.get(D),n=e.get(Q),r=e._getBoxSurroundingInfo(t),i=e._getBoxSurroundingInfo(n);e.nodeSurrounding=r,e.wrapperSurrounding=i,e.totalVSurrounding=r.totalVPadding+i.totalVBorder,e.totalHSurrounding=r.totalHPadding+i.totalHBorder},_setActiveHandlesUI:function(e){var t=this,n=t.get(g);n&&(e?(t.eachHandle(function(e){e.removeClass(Et)}),n.addClass(Et)):n.removeClass(Et))},_setHandles:function(t){var n=this,i=[];return r(t)?i=t:o(t)&&(t.toLowerCase()===y?i=n.ALL_HANDLES:e.each(t.split(l),function(e){var t=a(e);f(n.ALL_HANDLES,t)>-1&&i.push(t)})),i},_setHideHandlesUI:function(e){var t=this,n=t.get(Q);t.get(z)||(e?n.addClass(Nt):n.removeClass(Nt))},_setWrap:function(e){var t=this,n=t.get(D),r=n.get(P),i=t.get(G);return i.test(r)&&(e=!0),e},_defMouseUpFn:function(){var e=this;e.set(z,!1)},_defResizeFn:function(e){var t=this;t._resize(e)},_resize:function(e){var t=this;t._handleResizeAlignEvent(e.dragEvent),t._syncUI()},_defResizeAlignFn:function(e){var t=this;t._resizeAlign(e)},_resizeAlign:function(e){var t=this,n,r,i;t.lastInfo=t.info,t._updateInfo(e),n=t.info,t._calcResize(),t.con||(r=t.get(T)+t.totalVSurrounding,i=t.get(N)+t.totalHSurrounding,n.offsetHeight<=r&&t._checkSize(B,r),n.offsetWidth<=i&&t._checkSize(j,i))},_defResizeEndFn:function(e){var t=this;t._resizeEnd(e)},_resizeEnd:function(e){var t=this,n=e.dragEvent.target;n.actXY=[],t._syncUI(),t._setActiveHandlesUI(!1),t.set(m,null),t.set(g,null),t.handle=null},_defResizeStartFn:function(e){var t=this;t._resizeStart(e)},_resizeStart:function(e){var t=this,n=t.get(Q);t.handle=t.get(m),t.set(z,!0),t._updateSurroundingInfo(),t.originalInfo=t._getInfo(n,e),t._updateInfo(e)},_handleMouseUpEvent:function(e){this.fire(Y,{dragEvent:e,info:this.info})},_handleResizeEvent:function(e){this.fire(Z,{dragEvent:e,info:this.info})},_handleResizeAlignEvent:function(e){this.fire(et,{dragEvent:e,info:this.info})},_handleResizeEndEvent:function(e){this.fire(tt,{dragEvent:e,info:this.info})},_handleResizeStartEvent:function(e){this.get(m)||this._setHandleFromNode(e.target.get("node")),this.fire(nt,{dragEvent:e,info:this.info})},_onWrapperMouseEnter:function(){var e=this;e.get(b)&&e._setHideHandlesUI(!1)},_onWrapperMouseLeave:function(){var e=this;e.get(b)&&e._setHideHandlesUI(!0)},_setHandleFromNode:function(e){var t=this,n=t._extractHandleName(e);t.get(z)||(t.set(m,n),t.set(g,e),t._setActiveHandlesUI(!0),t._updateChangeHandleInfo(n))},_onHandleMouseEnter:function(e){this._setHandleFromNode(e.currentTarget)},_onHandleMouseLeave:function(){var e=this;e.get(z)||e._setActiveHandlesUI(!1)},_valueHandlesWrapper:function(){return e.Node.create(this.HANDLES_WRAP_TEMPLATE)},_valueWrapper:function(){var t=this,n=t.get(D),r=n.get(I),i=n;return t.get(K)&&(i=e.Node.create(t.WRAP_TEMPLATE),r&&r.insertBefore(i,n),i.append(n),t._copyStyles(n,i),n.setStyles({position:X,left:0,top:0})),i}}),e.each(e.Resize.prototype.ALL_HANDLES,function(t){e.Resize.ATTRS[dt(t)]={setter:function(){return this._buildHandle(t)},value:null,writeOnce:!0}})},"3.9.0pr3",{requires:["base","widget","event","oop","dd-drag","dd-delegate","dd-drop"],skinnable:!0});