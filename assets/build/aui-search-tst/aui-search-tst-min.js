YUI.add("aui-search-tst",function(e,t){var n=e.Lang,t="TernarySearchTree",r="character",i="child",s="largerNode",o="smallerNode",u="word",a=e.Component.create({NAME:t,NS:"ternarysearchtree",EXTENDS:e.Base,prototype:{add:function(e){var t=this,r=t._root,i=t._insert(r,e,0);n.isValue(r)||(t._root=i)},contains:function(e){var t=this,r=t._search(t._root,e,0);return!!n.isValue(r)&&!!r.isEndOfWord()},empty:function(){var e=this;e._root=null},patternMatch:function(e){var t=this,n=[];return t._patternMatch(t._root,e,0,n),n},prefixSearch:function(e){var t=this,n=[],r=t._search(t._root,e,0);return r&&t._inOrderTraversal(r.get(i),n),n},_inOrderTraversal:function(e,t){var r=this;if(!n.isValue(e))return;r._inOrderTraversal(e.get(o),t),e.isEndOfWord()&&t.push(e.get(u)),r._inOrderTraversal(e.get(i),t),r._inOrderTraversal(e.get(s),t)},_insert:function(t,a,f){var l=this,c=a.charAt(f);return n.isValue(t)?c===t.get(r)?f+1<a.length?t.set(i,l._insert(t.get(i),a,f+1)):t.set(u,a):c<t.get(r)?t.set(o,l._insert(t.get(o),a,f)):t.set(s,l._insert(t.get(s),a,f)):t=l._insert(new e.TernarySearchNode({character:c}),a,f),t},_patternMatch:function(e,t,f,l){var c=this;if(n.isValue(e)){var h=t.charAt(f),p=e.get(r),d=a.PATTERN_CHAR;(h===d||h<p)&&c._patternMatch(e.get(o),t,f,l);if(h===d||h===p)f+1<t.length?c._patternMatch(e.get(i),t,f+1,l):e.isEndOfWord()&&l.push(e.get(u));(h===d||h>p)&&c._patternMatch(e.get(s),t,f,l)}},_search:function(e,t,u){var a=this,f=e;if(n.isValue(e)){var l=t.charAt(u),c=e.get(r);l===c?u+1<t.length&&(f=a._search(e.get(i),t,u+1)):l<c?f=a._search(e.get(o),t,u):f=a._search(e.get(s),t,u)}return f}}});a.PATTERN_CHAR="?",e.TernarySearchTree=a;var n=e.Lang,t="TernarySearchNode",f=e.Component.create({NAME:t,NS:"ternarysearchnode",ATTRS:{character:{validator:"_validateCharacter",writeOnce:!0},child:{validator:"_validateChild"},largerNode:{validator:"_isInstanceOfNode"},smallerNode:{validator:"_isInstanceOfNode"},word:{validator:n.isString}},EXTENDS:e.Base,prototype:{isEndOfWord:function(){return!!this.get("word")},_isInstanceOfNode:function(t){return t instanceof e.TernarySearchNode},_validateCharacter:function(e){return n.isString(e)&&e.length===1}}});e.TernarySearchNode=f},"2.0.0pr5",{requires:["aui-component"]});
