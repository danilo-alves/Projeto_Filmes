YUI.add("axis-numeric-base",function(e,t){function n(){}n.NAME="numericImpl",n.ATTRS={alwaysShowZero:{value:!0},labelFormat:{value:{prefix:"",thousandsSeparator:"",decimalSeparator:"",decimalPlaces:"0",suffix:""}},roundingMethod:{value:"niceNumber"}},n.prototype={initializer:function(){this.after("alwaysShowZeroChange",this._keyChangeHandler),this.after("roundingMethodChange",this._keyChangeHandler)},formatLabel:function(t,n){return n?e.DataType.Number.format(t,n):t},getTotalByKey:function(e){var t=0,n=this.getDataByKey(e),r=0,i,s=n?n.length:0;for(;r<s;++r)i=parseFloat(n[r]),isNaN(i)||(t+=i);return t},_type:"numeric",_getMinimumUnit:function(e,t,n){return this._getNiceNumber(Math.ceil((e-t)/n))},_getNiceNumber:function(e){var t=e,n=Math.ceil(Math.log(t)*.4342944819032518),r=Math.pow(10,n),i;return r/2>=t?(i=Math.floor((r/2-t)/(Math.pow(10,n-1)/2)),t=r/2-i*Math.pow(10,n-1)/2):t=r,isNaN(t)?e:t},_updateMinAndMax:function(){var e=this.get("data"),t,n,r,i,s=0,o=this.get("setMax"),u=this.get("setMin");if(!o||!u){if(e&&e.length&&e.length>0){r=e.length;for(;s<r;s++){i=e[s];if(isNaN(i)){t=o?this._setMaximum:t,n=u?this._setMinimum:n;continue}u?n=this._setMinimum:n===undefined?n=i:n=Math.min(i,n),o?t=this._setMaximum:t===undefined?t=i:t=Math.max(i,t),this._actualMaximum=t,this._actualMinimum=n}}this._roundMinAndMax(n,t,u,o)}},_roundMinAndMax:function(e,t,n,r){var i,s,o=e>=0,u=t>0,a,f,l,c,h,p,d,v=this.getTotalMajorUnits()-1,m=this.get("alwaysShowZero"),g=this.get("roundingMethod"),y=(t-e)/v>=1;if(g)if(g==="niceNumber"){i=this._getMinimumUnit(t,e,v);if(o&&u)(m||e<i)&&!n?(e=0,i=this._getMinimumUnit(t,e,v)):e=this._roundDownToNearest(e,i),r?m||(e=t-i*v):n?t=e+i*v:t=this._roundUpToNearest(t,i);else if(u&&!o)if(m){c=Math.round(v/(-1*e/t+1)),c=Math.max(Math.min(c,v-1),1),h=v-c,p=Math.ceil(t/c),d=Math.floor(e/h)*-1;if(n){while(d<p&&h>=0)h--,c++,p=Math.ceil(t/c),d=Math.floor(e/h)*-1;h>0?t=d*c:t=e+i*v}else if(r){while(p<d&&c>=0)h++,c--,d=Math.floor(e/h)*-1,p=Math.ceil(t/c);c>0?e=p*h*-1:e=t-i*v}else i=Math.max(p,d),i=this._getNiceNumber(i),t=i*c,e=i*h*-1}else r?e=t-i*v:n?t=e+i*v:(e=this._roundDownToNearest(e,i),t=this._roundUpToNearest(t,i));else n?m?t=0:t=e+i*v:r?e=t-i*v:m||t===0||t+i>0?(t=0,i=this._getMinimumUnit(t,e,v),e=t-i*v):(e=this._roundDownToNearest(e,i),t=this._roundUpToNearest(t,i))}else g==="auto"?o&&u?((m||e<(t-e)/v)&&!n&&(e=0),i=(t-e)/v,y?(i=Math.ceil(i),t=e+i*v):t=e+Math.ceil(i*v*1e5)/1e5):u&&!o?m?(c=Math.round(v/(-1*e/t+1)),c=Math.max(Math.min(c,v-1),1),h=v-c,y?(p=Math.ceil(t/c),d=Math.floor(e/h)*-1,i=Math.max(p,d),t=i*c,e=i*h*-1):(p=t/c,d=e/h*-1,i=Math.max(p,d),t=Math.ceil(i*c*1e5)/1e5,e=Math.ceil(i*h*1e5)/1e5*-1)):(i=(t-e)/v,y&&(i=Math.ceil(i)),e=Math.round(this._roundDownToNearest(e,i)*1e5)/1e5,t=Math.round(this._roundUpToNearest(t,i)*1e5)/1e5):(i=(t-e)/v,y&&(i=Math.ceil(i)),m||t===0||t+i>0?(t=0,i=(t-e)/v,y?(Math.ceil(i),e=t-i*v):e=t-Math.ceil(i*v*1e5)/1e5):(e=this._roundDownToNearest(e,i),t=this._roundUpToNearest(t,i))):!isNaN(g)&&isFinite(g)&&(i=g,s=i*v,a=t-e>s,l=this._roundDownToNearest(e,i),f=this._roundUpToNearest(t,i),r?e=t-s:n?t=e+s:o&&u?(m||l<=0?e=0:e=l,t=e+s):u&&!o?(e=l,t=f):(m||f>=0?t=0:t=f,e=t-s));this._dataMaximum=t,this._dataMinimum=e},_roundToNearest:function(e,t){t=t||1;var n=Math.round(this._roundToPrecision(e/t,10))*t;return this._roundToPrecision(n,10)},_roundUpToNearest:function(e,t){return t=t||1,Math.ceil(this._roundToPrecision(e/t,10))*t},_roundDownToNearest:function(e,t){return t=t||1,Math.floor(this._roundToPrecision(e/t,10))*t},_roundToPrecision:function(e,t){t=t||0;var n=Math.pow(10,t);return Math.round(n*e)/n}},e.NumericImpl=n,e.NumericAxisBase=e.Base.create("numericAxisBase",e.AxisBase,[e.NumericImpl])},"3.9.0pr3",{requires:["axis-base"]});
