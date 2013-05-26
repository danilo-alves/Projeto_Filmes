YUI.add("aui-aria",function(e,t){var n=e.Lang,r=n.isBoolean,i=n.isFunction,s=n.isObject,o=n.isString,u="attributeValueFormat",a="attributes",f="aria",l="aria-",c="attributeNode",h="boundingBox",p="host",d="role",v="roleName",m="roleNode",g="validateW3C",y="Change",b="",w=/([^a-z])/ig,E="aria:processAttribute",S=e.cached(function(e){return e.replace(w,function(){return b}).toLowerCase()}),x=e.Component.create({NAME:f,NS:f,ATTRS:{attributes:{value:{},validator:s},attributeValueFormat:{value:function(e){return e},validator:i},attributeNode:{writeOnce:!0,setter:e.one,valueFn:function(){return this.get(p).get(h)}},roleName:{valueFn:function(){var e=this,t=e.get(p),n=S(t.constructor.NAME||b);return e.isValidRole(n)?n:b},validator:o},roleNode:{writeOnce:!0,setter:e.one,valueFn:function(){return this.get(p).get(h)}},validateW3C:{value:!0,validator:r}},EXTENDS:e.Plugin.Base,prototype:{initializer:function(){var e=this;e.publish(E,{defaultFn:e._defProcessFn,queuable:!1,emitFacade:!0,bubbles:!0,prefix:f}),e._uiSetRoleName(e.get(v)),e.after("roleNameChange",e._afterRoleNameChange),e._bindHostAttributes()},isValidAttribute:function(t){var n=this;return n.get(g)?e.Plugin.Aria.W3C_ATTRIBUTES[t]:!0},isValidRole:function(t){var n=this;return n.get(g)?e.Plugin.Aria.W3C_ROLES[t]:!0},setAttribute:function(e,t,n){var r=this;return r.isValidAttribute(e)?((n||r.get(c)).set(l+e,t),!0):!1},setAttributes:function(t){var n=this;e.Array.each(t,function(e,t,r){n.setAttribute(e.name,e.value,e.node)})},setRole:function(e,t){var n=this;return n.isValidRole(e)?((t||n.get(m)).set(d,e),!0):!1},setRoles:function(t){var n=this;e.Array.each(t,function(e,t,r){n.setRole(e.name,e.node)})},_afterHostAttributeChange:function(e){var t=this;t._handleProcessAttribute(e)},_afterRoleNameChange:function(e){var t=this;t._uiSetRoleName(e.newVal)},_bindHostAttributes:function(){var t=this,n=t.get(a);e.each(n,function(e,n){var r=t._getAriaAttribute(e,n);t._handleProcessAttribute({aria:r}),t.afterHostEvent(n+y,function(e){e.aria=r,t._afterHostAttributeChange(e)})})},_defProcessFn:function(e){var t=this;t._setAttribute(e.aria)},_getAriaAttribute:function(t,n){var r=this,i=r.get(u),a={};return o(t)?a=e.merge(a,{ariaName:t,attrName:n,format:i,node:null}):s(t)&&(a=e.mix(t,{ariaName:b,attrName:n,format:i,node:null})),a},_handleProcessAttribute:function(e){var t=this;t.fire(E,{aria:e.aria})},_setAttribute:function(e){var t=this,n=t.get(p),r=n.get(e.attrName),s=e.node;i(s)&&(s=s.apply(t,[e])),t.setAttribute(e.ariaName,e.format.apply(t,[r,e]),s)},_uiSetRoleName:function(e){var t=this;t.setRole(e)}}});e.Plugin.Aria=x,e.Plugin.Aria.W3C_ROLES={alert:1,alertdialog:1,application:1,article:1,banner:1,button:1,checkbox:1,columnheader:1,combobox:1,command:1,complementary:1,composite:1,contentinfo:1,definition:1,dialog:1,directory:1,document:1,form:1,grid:1,gridcell:1,group:1,heading:1,img:1,input:1,landmark:1,link:1,list:1,listbox:1,listitem:1,log:1,main:1,marquee:1,math:1,menu:1,menubar:1,menuitem:1,menuitemcheckbox:1,menuitemradio:1,navigation:1,note:1,option:1,presentation:1,progressbar:1,radio:1,radiogroup:1,range:1,region:1,roletype:1,row:1,rowheader:1,scrollbar:1,search:1,section:1,sectionhead:1,select:1,separator:1,slider:1,spinbutton:1,status:1,structure:1,tab:1,tablist:1,tabpanel:1,textbox:1,timer:1,toolbar:1,tooltip:1,tree:1,treegrid:1,treeitem:1,widget:1,window:1},e.Plugin.Aria.W3C_ATTRIBUTES={activedescendant:1,atomic:1,autocomplete:1,busy:1,checked:1,controls:1,describedby:1,disabled:1,dropeffect:1,expanded:1,flowto:1,grabbed:1,haspopup:1,hidden:1,invalid:1,label:1,labelledby:1,level:1,live:1,multiline:1,multiselectable:1,orientation:1,owns:1,posinset:1,pressed:1,readonly:1,relevant:1,required:1,selected:1,setsize:1,sort:1,valuemax:1,valuemin:1,valuenow:1,valuetext:1}},"2.0.0pr5",{requires:["plugin","aui-component"]});
