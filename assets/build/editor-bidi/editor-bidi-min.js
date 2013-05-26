YUI.add("editor-bidi",function(e,t){var n=function(){n.superclass.constructor.apply(this,arguments)},r="host",i="dir",s="BODY",o="nodeChange",u="bidiContextChange",a="style";e.extend(n,e.Base,{lastDirection:null,firstEvent:null,_checkForChange:function(){var e=this.get(r),t=e.getInstance(),i=new t.EditorSelection,s,o;i.isCollapsed?(s=n.blockParent(i.focusNode),s&&(o=s.getStyle("direction"),o!==this.lastDirection&&(e.fire(u,{changedTo:o}),this.lastDirection=o))):(e.fire(u,{changedTo:"select"}),this.lastDirection=null)},_afterNodeChange:function(e){if(this.firstEvent||n.EVENTS[e.changedType])this._checkForChange(),this.firstEvent=!1},_afterMouseUp:function(){this._checkForChange(),this.firstEvent=!1},initializer:function(){var t=this.get(r);this.firstEvent=!0,t.after(o,e.bind(this._afterNodeChange,this)),t.after("dom:mouseup",e.bind(this._afterMouseUp,this))}},{EVENTS:{"backspace-up":!0,"pageup-up":!0,"pagedown-down":!0,"end-up":!0,"home-up":!0,"left-up":!0,"up-up":!0,"right-up":!0,"down-up":!0,"delete-up":!0},BLOCKS:e.EditorSelection.BLOCKS,DIV_WRAPPER:"<DIV></DIV>",blockParent:function(t,r){var i=t,o,u;return i||(i=e.one(s)),i.test(n.BLOCKS)||(i=i.ancestor(n.BLOCKS)),r&&i.test(s)&&(o=e.Node.create(n.DIV_WRAPPER),i.get("children").each(function(e,t){t===0?u=e:o.append(e)}),u.replace(o),o.prepend(u),i=o),i},_NODE_SELECTED:"bidiSelected",addParents:function(e){var t,r,i;tester=function(e){if(!e.getData(n._NODE_SELECTED))return i=!1,!0};for(t=0;t<e.length;t+=1)e[t].setData(n._NODE_SELECTED,!0);for(t=0;t<e.length;t+=1)r=e[t].get("parentNode"),!r.test(s)&&!r.getData(n._NODE_SELECTED)&&(i=!0,r.get("children").some(tester),i&&(e.push(r),r.setData(n._NODE_SELECTED,!0)));for(t=0;t<e.length;t+=1)e[t].clearData(n._NODE_SELECTED);return e},NAME:"editorBidi",NS:"editorBidi",ATTRS:{host:{value:!1}},RE_TEXT_ALIGN:/text-align:\s*\w*\s*;/,removeTextAlign:function(e){return e&&(e.getAttribute(a).match(n.RE_TEXT_ALIGN)&&e.setAttribute(a,e.getAttribute(a).replace(n.RE_TEXT_ALIGN,"")),e.hasAttribute("align")&&e.removeAttribute("align")),e}}),e.namespace("Plugin"),e.Plugin.EditorBidi=n,e.Plugin.ExecCommand.COMMANDS.bidi=function(t,s){var o=this.getInstance(),u=new o.EditorSelection,a=this.get(r).get(r).editorBidi,f,l,c,h,p,d;if(!a){e.error("bidi execCommand is not available without the EditorBiDi plugin.");return}return o.EditorSelection.filterBlocks(),u.isCollapsed?(l=n.blockParent(u.anchorNode),l||(l=o.one("body").one(o.EditorSelection.BLOCKS)),l=n.removeTextAlign(l),s||(d=l.getAttribute(i),!d||d==="ltr"?s="rtl":s="ltr"),l.setAttribute(i,s),e.UA.ie&&(c=l.all("br.yui-cursor"),c.size()===1&&l.get("childNodes").size()===1&&c.remove()),f=l):(h=u.getSelected(),p=[],h.each(function(e){p.push(n.blockParent(e))}),p=o.all(n.addParents(p)),p.each(function(e){var t=s;e=n.removeTextAlign(e),t||(d=e.getAttribute(i),!d||d==="ltr"?t="rtl":t="ltr"),e.setAttribute(i,t)}),f=p),a._checkForChange(),f}},"3.9.0pr3",{requires:["editor-base"]});
