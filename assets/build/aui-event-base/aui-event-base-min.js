YUI.add("aui-event-base",function(e,t){var n=e.Lang,r=e.Array,i=e.DOMEventFacade,s=i.prototype,o="BACKSPACE",u="CAPS_LOCK",a="DOWN",f="ENTER",l="ESC",c="INSERT",h="PAGE_UP",p="PRINT_SCREEN",d="SHIFT",v="TAB",m="WIN_IME",g="",y={BACKSPACE:8,TAB:9,NUM_CENTER:12,ENTER:13,RETURN:13,SHIFT:16,CTRL:17,ALT:18,PAUSE:19,CAPS_LOCK:20,ESC:27,SPACE:32,PAGE_UP:33,PAGE_DOWN:34,END:35,HOME:36,LEFT:37,UP:38,RIGHT:39,DOWN:40,PRINT_SCREEN:44,INSERT:45,DELETE:46,ZERO:48,ONE:49,TWO:50,THREE:51,FOUR:52,FIVE:53,SIX:54,SEVEN:55,EIGHT:56,NINE:57,A:65,B:66,C:67,D:68,E:69,F:70,G:71,H:72,I:73,J:74,K:75,L:76,M:77,N:78,O:79,P:80,Q:81,R:82,S:83,T:84,U:85,V:86,W:87,X:88,Y:89,Z:90,CONTEXT_MENU:93,NUM_ZERO:96,NUM_ONE:97,NUM_TWO:98,NUM_THREE:99,NUM_FOUR:100,NUM_FIVE:101,NUM_SIX:102,NUM_SEVEN:103,NUM_EIGHT:104,NUM_NINE:105,NUM_MULTIPLY:106,NUM_PLUS:107,NUM_MINUS:109,NUM_PERIOD:110,NUM_DIVISION:111,F1:112,F2:113,F3:114,F4:115,F5:116,F6:117,F7:118,F8:119,F9:120,F10:121,F11:122,F12:123,NUM_LOCK:144,WIN_KEY:224,WIN_IME:229,hasModifier:function(e){var t=this;return e&&(e.ctrlKey||e.altKey||e.shiftKey||e.metaKey)},isKey:function(e,t){var n=this;return t&&(n[t]||n[t.toUpperCase()])==e},isKeyInRange:function(e,t,n){var r=this,i=!1;if(t&&n){var s=r[t]||r[t.toUpperCase()],o=r[n]||r[n.toUpperCase()];i=s&&o&&e>=s&&e<=o}return i},isKeyInSet:function(e,t){var n=this,i=r(arguments,1,!0);return n._isKeyInSet(e,i)},isNavKey:function(e){var t=this;return t.isKeyInRange(e,h,a)||t.isKeyInSet(e,f,v,l)},isSpecialKey:function(e,t){var n=this,r=t=="keypress"&&n.ctrlKey;return r||n.isNavKey(e)||n.isKeyInRange(e,d,u)||n.isKeyInSet(e,o,p,c,m)},_isKeyInSet:function(e,t){var n=this,r=t.length,i=!1,s,o;while(r--){s=t[r],o=s&&(n[s]||n[String(s).toUpperCase()]);if(e==o){i=!0;break}}return i}};e.mix(s,{hasModifier:function(){var e=this;return y.hasModifier(e)},isKey:function(e){var t=this;return y.isKey(t.keyCode,e)},isKeyInRange:function(e,t){var n=this;return y.isKeyInRange(n.keyCode,e,t)},isKeyInSet:function(){var e=this,t=r(arguments,0,!0);return y._isKeyInSet(e.keyCode,t)},isNavKey:function(){var e=this;return y.isNavKey(e.keyCode)},isSpecialKey:function(){var e=this;return y.isSpecialKey(e.keyCode,e.type)}}),e.Event.KeyMap=y,e.Event.supportsDOMEvent=e.supportsDOMEvent},"2.0.0pr5",{requires:["event-base"]});
