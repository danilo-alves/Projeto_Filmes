YUI.add("series-areaspline-stacked",function(e,t){e.StackedAreaSplineSeries=e.Base.create("stackedAreaSplineSeries",e.AreaSeries,[e.CurveUtil,e.StackingUtil],{drawSeries:function(){this._stackCoordinates(),this.drawStackedAreaSpline()}},{ATTRS:{type:{value:"stackedAreaSpline"}}})},"3.9.0pr3",{requires:["series-stacked","series-areaspline"]});
