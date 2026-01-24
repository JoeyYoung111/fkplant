<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>矛盾风险时光轴</title>
    <link rel="stylesheet" href="<c:url value="/css/timeaxis/css/style.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
  </head>
<body>
<div class="content">
  <div class="wrapper">
    <div class="light"><i></i></div>
    <hr class="line-left">
    <hr class="line-right">
    <div class="main">
      <h1 class="title">${contradictionInfo.cdtname }</h1>
      <c:forEach items="${axisList }" var="axis" varStatus="num">
      	<div class="year">
	        <h2><a href="#">${axis.year }<i></i></a></h2>
	        <div class="list">
	          <ul>
	          	<c:forEach items="${axis.eventList }" var="event" varStatus="num1">
	          		<li class="cls">
		              <p class="date">${event.eventtime }</p>
		              <p class="intro">${event.eventname }【${event.eventtype}】</p>
		              <p class="version">&nbsp;</p>
		              <div class="more">
		                <p>${event.eventdetail }</p>
		              </div>
		            </li>
	          	</c:forEach>
	          </ul>
	        </div>
	      </div>
      </c:forEach>
    </div>
  </div>
</div>
<script>
	$(".main .year .list").each(function (e, target) {
	    var $target=  $(target),
	        $ul = $target.find("ul");
	    $target.height($ul.outerHeight()), $ul.css("position", "absolute");
	}); 
	$(".main .year>h2>a").click(function (e) {
	    e.preventDefault();
	    $(this).parents(".year").toggleClass("close");
	});
</script>
</body>
</html>