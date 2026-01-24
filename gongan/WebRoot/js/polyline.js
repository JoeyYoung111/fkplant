	//添加线
	function addPolyline(points,lineColor,lineOpacity,strokeWeight){
		return mapAddPolyline(map,points,lineColor,lineOpacity,strokeWeight);
	}
	
	//添加覆盖物线,并返回覆盖物
	function mapAddPolyline(map, points, lineColor, lineOpacity, strokeWeight) {
	    if (strokeWeight == null) {
	        strokeWeight = 1;
	    }
	        var pl = new BMap.Polyline(points, {
	            strokeColor: lineColor,
	            strokeOpacity: lineOpacity,
	            strokeWeight: strokeWeight
	        });
	        map.addOverlay(pl);
			return pl;
	}
	//添加多个覆盖物线
	function mapAddPolylines(map, points, lineColor, lineOpacity, strokeWeight) {
	    if (strokeWeight == null) {
	        strokeWeight = 1;
	    }
	    for (var i = 0; i < points.length; i++) {
			mapAddPolyline(map, points[i], lineColor, lineOpacity, strokeWeight);
	    }
	}
