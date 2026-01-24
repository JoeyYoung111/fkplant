	//添加面
	function addPolygon(points,lineOpacity,lineColor,fillOpacity,fillColor,strokeWeight){
		return mapAddPolygon(map,points,lineOpacity,lineColor,fillOpacity,fillColor,strokeWeight);
	}
	
	//添加覆盖物块,并返回覆盖物
	function mapAddPolygon(map, points, lineOpacity, lineColor, fillOpacity, fillColor, strokeWeight) {
	    if (strokeWeight == null) {
	        strokeWeight = 1;
	    }
	        var ply = new BMap.Polygon(points, {
	            strokeWeight: strokeWeight,
	            strokeColor: fillColor
	        });
	        ply.setFillOpacity(fillOpacity);
	        ply.setFillColor(fillColor);
	        ply.setStrokeOpacity(lineOpacity);
	        map.addOverlay(ply);
			return ply;
	}
	//添加多个覆盖物快
	function mapAddPolygons(map, points, lineOpacity, lineColor, fillOpacity, fillColor, strokeWeight) {
	    if (strokeWeight == null) {
	        strokeWeight = 1;
	    }
	    for (var i = 0; i < points.length; i++) {
			mapAddPolygon(map, points[i], lineOpacity, lineColor, fillOpacity, fillColor, strokeWeight);
	    }
	}
