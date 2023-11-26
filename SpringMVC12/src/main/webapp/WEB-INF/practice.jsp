<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Local Cesium</title>
<!-- Include the CesiumJS JavaScript and CSS files -->
<script src="https://cesium.com/downloads/cesiumjs/releases/1.111/Build/Cesium/Cesium.js"></script>
<link href="https://cesium.com/downloads/cesiumjs/releases/1.111/Build/Cesium/Widgets/widgets.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 전체를 갖고있는 ajax가 아닌거 같아서 추가시킴 -->
<style>
.aaa {
	width: 100%;
	height: 800px;
}

.titleFont {
	font-size: 50px;
}

.titleFont1 {
	font-size: 35px;
}
</style>
</head>
<body>
	<script type="module">
// --------------------------------------- 지형 정보 띄우기------------------------------------------------
    // Your access token can be found at: https://ion.cesium.com/tokens.
    // This is the default access token from your ion account
	// ★인증을 위한 토큰
    Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI3NzUyNzY4NS04MzgwLTQ0YzYtYTIxYy1mODc1NDg3YWYwZTEiLCJpZCI6MTgwMDA4LCJpYXQiOjE3MDA2NDkzMTJ9.PsQxg7Y897tFRsd5aQqKhNtjRRgngQSiL-QEO17C9co';
	
    // Initialize the Cesium Viewer in the HTML element with the `cesiumContainer` ID.
    // ★ Id가 있는 HTML 요소에서 Cesium 뷰어를 초기화합니다 'cesiumContainer'
    const viewer = new Cesium.Viewer('cesiumContainer', {
      terrain: Cesium.Terrain.fromWorldTerrain(), // 뷰어는 Cesium World Terrain에서 얻은 지형 공급자로 구성됩니다.
    });    
	
    // Fly the camera to San Francisco at the given longitude, latitude, and height.
	// ★ 이 섹션에서는 카메라가 특정 위치로 날아가도록 애니메이션을 적용합니다.
	// ★ 목적지는 경도, 위도, 높이 (각각 도와 미터)로 지정된 샌프란시스코로 설정됩니다.
	// ★ 카메라 방향도 0도 방향과 피치 -90도로 설정됩니다.
    viewer.camera.flyTo({
      destination: Cesium.Cartesian3.fromDegrees(127.3845475, 36.3504119, 25000),
      orientation: {
        heading: Cesium.Math.toRadians(0.0),
        pitch: Cesium.Math.toRadians(-90.0),
      }
    });
	// 이 부분에서는 Cesium OSM Buildings 레이어를 장면에 추가합니다. 
	// OpenStreetMap(OSM) 건물을 나타내는 타일 세트를 비동기식으로 생성하고 이를 뷰어의 장면 프리미티브에 추가합니다.
    // Add Cesium OSM Buildings, a global 3D buildings layer.
    const buildingTileset = await Cesium.createOsmBuildingsAsync();
    viewer.scene.primitives.add(buildingTileset);
// --------------------------------------- 마커 정보 띄우기(대피소 데이터)------------------------------------------------	    
//대피소 통신
$.ajax({
	url : "http://apis.data.go.kr/1741000/TsunamiShelter3/getTsunamiShelter1List?ServiceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=10&type=json",
	type : "get",
	dataType : "json",
	success : shelter
});

//대피소 콜백
function shelter(data2){
	alert('대피소 콜백 함수 실행됨');
	console.log(data2);
$.each(data2.TsunamiShelter[1].row, function(index, item){
let czml = [
	  {
	    id: "document",
	    name: "CZML Point",
	    version: "1.0",
	  },
	  {
	    id: "aaa",
	    name: "대피소",
	    position: {
	      cartographicDegrees: [127.3845475, 36.3504119, 500],
	    },
	    point: {
	      color: {
	        rgba: [255, 255, 255, 255],
	      },
	      outlineColor: {
	        rgba: [255, 0, 0, 255],
	      },
	      outlineWidth: 4,
	      pixelSize: 20,
	    },
	  },
	];		

	  czml[1].position.cartographicDegrees = [item.lon, item.lat, 1000];

	  const dataSourcePromise = Cesium.CzmlDataSource.load(czml);
	  viewer.dataSources.add(dataSourcePromise);
	  viewer.zoomTo(dataSourcePromise);

	});// 반복문 끝
}
// --------------------------------------- 마커 정보 띄우기(타슈 데이터)------------------------------------------------	    
//타슈 통신
$.ajax({
	url : "https://apis.data.go.kr/6300000/openapi2022/tasuInfo/gettasuInfo?serviceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=30",
	type : "get",
	dataType : "json",
	success : tasu
});

// 타슈 콜백
function tasu(data){
	alert('타슈데이터 콜백 함수 실행됨');

$.each(data.response.body.items, function(index, item){
let czml = [
	  {
	    id: "document",
	    name: "CZML Point",
	    version: "1.0",
	  },
	  {
	    id: "aaa",
	    name: "point",
	    position: {
	      cartographicDegrees: [127.3845475, 36.3504119, 500],
	    },
	    point: {
	      color: {
	        rgba: [255, 255, 255, 255],
	      },
	      outlineColor: {
	        rgba: [0, 255, 0, 255],
	      },
	      outlineWidth: 4,
	      pixelSize: 20,
	    },
	  },
	];		

	  czml[1].position.cartographicDegrees = [item.loCrdnt, item.laCrdnt, 1000];
	  czml[1].name = "타슈";

	  const dataSourcePromise = Cesium.CzmlDataSource.load(czml);
	  viewer.dataSources.add(dataSourcePromise);
	  viewer.zoomTo(dataSourcePromise);

	});// 반복문 끝
}
// --------------------------------------- 마커 정보 띄우기(신호등 데이터)------------------------------------------------	    
$.ajax({
	url : "http://apis.data.go.kr/6260000/BusanTrafficLightInfoService/getWarningLightInfo?serviceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=30&http://apis.data.go.kr/6260000/BusanTrafficLightInfoService/getWarningLightInfo?serviceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=5&resultType=json",
	type : "get",
	dataType : "json",
	success : trafficLight
});

// 신호등 콜백
function trafficLight(data1){
	//alert('신호등데이터 콜백 함수 실행됨');

$.each(data1.getWarningLightInfo.body.items.item, function(index, item){
let czml = [
	  {
	    id: "document",
	    name: "CZML Point",
	    version: "1.0",
	  },
	  {
	    id: "aaa",
	    name: "신호등",
	    position: {
	      cartographicDegrees: [127.3845475, 36.3504119, 500],
	    },
	    point: {
	      color: {
	        rgba: [255, 255, 255, 255],
	      },
	      outlineColor: {
	        rgba: [0, 0, 255, 255],
	      },
	      outlineWidth: 4,
	      pixelSize: 20,
	    },
	  },
	];		

	  czml[1].position.cartographicDegrees = [item.lng, item.lat, 1000];

	  const dataSourcePromise = Cesium.CzmlDataSource.load(czml);
	  viewer.dataSources.add(dataSourcePromise);
	  viewer.zoomTo(dataSourcePromise);

	});// 반복문 끝
}
</script>
	<div id="titleDiv">
		<span class="titleFont">Cesium</span> <br> <span
			class="titleFont1"><p>공공데이터 -> ajax</p></span> <br>
	</div>
	<div id="cesiumContainer" id="aaa" class="aaa"></div>
	<div id="toolbar"></div>
	</div>
	<div><%@ include file="CesiumView.jsp" %></div>
</body>
</html>