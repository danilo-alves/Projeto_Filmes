YUI.add("series-spline",function(e,t){e.SplineSeries=e.Base.create("splineSeries",e.LineSeries,[e.CurveUtil,e.Lines],{drawSeries:function(){this.drawSpline()}},{ATTRS:{type:{value:"spline"}}})},"3.9.0pr3",{requires:["series-line","series-curve-util"]});
