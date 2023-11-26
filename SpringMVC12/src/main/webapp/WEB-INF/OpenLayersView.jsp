<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Local openLayers2</title>
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script><!-- 전체를 갖고있는 ajax가 아닌거 같아서 추가시킴 -->
  <script src="https://cdn.jsdelivr.net/npm/ol@v8.2.0/dist/ol.js"></script>
  <script src="https://cesium.com/downloads/cesiumjs/releases/1.111/Build/Cesium/Cesium.js"></script>
  <link href="https://cesium.com/downloads/cesiumjs/releases/1.111/Build/Cesium/Widgets/widgets.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v8.2.0/ol.css">
<style>
	.titleFont {
		font-size :50px;
	}
	.titleFont1 {
		font-size :35px;
	}
	.map {
        width: 80%;
        height: 400px;
      }
    /* 초기에 숨겨진 상태 */
    .aaa {
    	width: 80%;
		height: 400px;
        display: none;
    }
    table, th, td { border: 2px solid black; }
	table { border-collapse: collapse; margin-top : 20px;}
출처: https://inpa.tistory.com/entry/CSS-📚-테이블표-꾸미기 [Inpa Dev 👨‍💻:티스토리] 
</style>
<script type="text/javascript">
//null 값 check

var map;
$(document).ready(function() {
	 //-----------------------------myLocation 버튼 이벤트 실행-----------------------------
	$("#myLocation").on("click", function(){
		//alert("버튼이벤트check");
		var features = [];
		    	const x = parseFloat(longitude);//경도
		    	const y = parseFloat(latitude);//위도
		    	point = new ol.geom.Point(ol.proj.fromLonLat([x, y]));
	        	feature = new ol.Feature(point);
	        features.push(feature); //feature 안에는 ol.Feature 객체들이 들어갑니다.
		
		// Create a vector source and layer to add the features to the map
	    var vectorSource = new ol.source.Vector({
	        features: features,
	    });
		
	    var vectorLayer = new ol.layer.Vector({
	        source: vectorSource,
	        style: new ol.style.Style({
	            image: new ol.style.Circle({
	                radius: 6,
	                fill: new ol.style.Fill({ color: 'green' }),  // Change the color to your preference
	                stroke: new ol.style.Stroke({ color: 'white', width: 2 })
	            })
	        })
	    });

	    // Add the vector layer to the map
	    map.addLayer(vectorLayer);

	    // Optional: Zoom to the extent of the features
	    var extent = vectorSource.getExtent();
	    map.getView().fit(extent, { padding: [30, 30, 30, 30] });
		
		
	});
	//-----------------------------------------myLocation 버튼 이벤트 실행 끝----------------------------------------------
	 $("#oL").on("click", function(){
	//function toggleOL(){
		var toDiOL = document.getElementById("map");
		var toDiCE = document.getElementById("cesiumContainer");
		if(toDiOL.style.display === "none"){//오픈레이어가 안보이면
			toDiOL.style.display = "block";//보이게해라
			toDiCE.style.display = "none";//세슘을 없애라
		}
	});
	//}
	 $("#Ce").on("click", function(){
	//function toggleCE(){
		var toDiOL = document.getElementById("map");
		var toDiCE = document.getElementById("cesiumContainer");
		if(toDiCE.style.display === "none"){//세슘 레이어가 안보이면
			toDiCE.style.display = "block";//보이게해라
			toDiOL.style.display = "none";//오픈레이어를 닫아라
		}
	});
	//}
	//타슈 통신
	$.ajax({
		url : "https://apis.data.go.kr/6300000/openapi2022/tasuInfo/gettasuInfo?serviceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=30",
		type : "get",
		dataType : "json",
		success : tasu
	});
	//신호등 통신
	$.ajax({
		url : "http://apis.data.go.kr/6260000/BusanTrafficLightInfoService/getWarningLightInfo?serviceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=30&http://apis.data.go.kr/6260000/BusanTrafficLightInfoService/getWarningLightInfo?serviceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=5&resultType=json",
		type : "get",
		dataType : "json",
		success : trafficLight
	});
	
	//대피소 통신
	$.ajax({
		url : "http://apis.data.go.kr/1741000/TsunamiShelter3/getTsunamiShelter1List?ServiceKey=7aPFpFd3LotfN9l36oEAdLuzylp%2FEfW0LgS%2BsD%2FTVoU7oNI5JkLUTjjXAX0se2mo4FanHC5dveLhCzwhq3a%2BBg%3D%3D&pageNo=1&numOfRows=5&type=json",
		type : "get",
		dataType : "json",
		success : shelter
	});
	
	//시민제보 통신
	$.ajax({
		url : "${contextPath}/citizenMap.do",
		type : "get",
		dataType : "json",
		success : citizenMap1,
		error : function(){alert("error");}
	});
	

	
//시민제보 insert 통신
 $("#submitButton").on("click", function(){
	 
var inputValue = document.getElementById("citizenFormData").value;
	$('citizenFormData').val('');//박스 초기화
	//alert("시민제보 insert 통신");
	$.ajax({
		url : "${contextPath}/citizenMapInsert.do?fData="+inputValue,
		type : "get",
		success : insertComplete(),
		error : function(error) { alert("error"); }
		});
	 });
});//ready

// 시민제보 insert 콜백
function insertComplete(){
 alert("등록이 완료되었습니다.");
}

// 시민제보 콜백
function citizenMap1(data){
	var features = [];
	//alert("시민제보가져오기콜백");
        var htmlString = "<table>";
         	htmlString += "<tr>";
        	htmlString += "<th>도로명주소</th>";
        	htmlString += "<th>지번</th>";
        	htmlString += "<th>경도</th>";
        	htmlString += "<th>위도</th>";
        	htmlString += "<th>제보시간</th>";
        	htmlString += "</tr>";
	$.each(data, function(index, item){
	    	road = item.road;
	    	jibun = item.jibun;
	    	x = parseFloat(item.x);
	    	y = parseFloat(item.y);
	    	today = item.today;
	    	
	    	point = new ol.geom.Point(ol.proj.fromLonLat([x, y]));
        	feature = new ol.Feature(point);
        	htmlString += "<tr>";
        	htmlString += "<td>"+road+"</td>";
        	htmlString += "<td>"+jibun+"</td>";
        	htmlString += "<td>"+x+"</td>";
        	htmlString += "<td>"+y+"</td>";
        	htmlString += "<td>"+today+"</td>";
        	htmlString += "</tr>";
        features.push(feature); //feature 안에는 ol.Feature 객체들이 들어갑니다.
	});
        	htmlString += "</table>";
        $("#yourContainerId").append(htmlString);
	
    var vectorSource = new ol.source.Vector({
        features: features,
    });
	
    var vectorLayer = new ol.layer.Vector({
        source: vectorSource,
        style: new ol.style.Style({
            image: new ol.style.Circle({
                radius: 6,
                fill: new ol.style.Fill({ color: 'red' }),  // Change the color to your preference
                stroke: new ol.style.Stroke({ color: 'white', width: 2 })
            })
        })
    });

    map.addLayer(vectorLayer);

    var extent = vectorSource.getExtent();
    map.getView().fit(extent, { padding: [3, 3, 3, 3] });
	
}
//---------------------------------------------
//대피소 콜백
function shelter(data2){
	var features = [];
	//alert('대피소 콜백 함수 실행됨');
	console.log(data2);
	
	$.each(data2.TsunamiShelter[1].row, function(index, item){
		console.log(item);
		var lon2 = parseFloat(item.lon);
		var lat2 = parseFloat(item.lat);
		
	    var point = new ol.geom.Point(ol.proj.fromLonLat([lon2, lat2]));
        var feature = new ol.Feature(point);
        
        features.push(feature); //feature 안에는 ol.Feature 객체들이 들어갑니다.
	});
	  // 사용자 정의 아이콘 이미지
    var bicycleIcon = new ol.style.Icon({
        src: '${contextPath}/resources/Image/exitIcon.png', // 이미지 파일의 경로를 설정하세요
        scale: 0.5, // 이미지의 크기를 조절합니다
        anchor: [0.5, 1], // 이미지의 기준점을 설정합니다
    });

    // Create a vector source and layer to add the features to the map
    var vectorSource = new ol.source.Vector({
        features: features,
    });

    var vectorLayer = new ol.layer.Vector({
        source: vectorSource,
        style: new ol.style.Style({
            image: bicycleIcon, // 사용자 정의 아이콘 이미지를 설정합니다
        }),
    });

    // Add the vector layer to the map
    map.addLayer(vectorLayer);

    // Optional: Zoom to the extent of the features
    var extent = vectorSource.getExtent();
    map.getView().fit(extent, { padding: [3, 3, 3, 3] });
}
//--------------------------------------------------------------------------------------------------
//신호등 콜백
function trafficLight(data1){
	var features = [];
	//alert('신호등데이터 콜백 함수 실행됨');
	console.log(data1);
	
	$.each(data1.getWarningLightInfo.body.items.item, function(index, item){
		var lon1 = parseFloat(item.lng);
		var lat1 = parseFloat(item.lat);
		
	    var point = new ol.geom.Point(ol.proj.fromLonLat([lon1, lat1]));
        var feature = new ol.Feature(point);
        
        features.push(feature);
	});
	
	  // 사용자 정의 아이콘 이미지
    var bicycleIcon = new ol.style.Icon({
        src: '${contextPath}/resources/Image/lampIcon.png', // 이미지 파일의 경로를 설정하세요
        scale: 0.5, // 이미지의 크기를 조절합니다
        anchor: [0.5, 1], // 이미지의 기준점을 설정합니다
    });

    var vectorSource = new ol.source.Vector({
        features: features,
    });

    var vectorLayer = new ol.layer.Vector({
        source: vectorSource,
        style: new ol.style.Style({
            image: bicycleIcon, // 사용자 정의 아이콘 이미지를 설정합니다
        }),
    });

    map.addLayer(vectorLayer);

    var extent = vectorSource.getExtent();
    map.getView().fit(extent, { padding: [3, 3, 3, 3] });
	
}
//--------------------------------------------------------------------------------------------------
// 타슈 콜백
function tasu(data){
var features = [];
	//alert( '타슈데이터 콜백 함수 실행됨' );
	// var aaa = data.response.body.items;
	// console.log(aaa);
	$.each(data.response.body.items, function(index, item){
		var lon = parseFloat(item.loCrdnt);
		var lat = parseFloat(item.laCrdnt);
		
	    var point = new ol.geom.Point(ol.proj.fromLonLat([lon, lat]));
        var feature = new ol.Feature(point);
        
        features.push(feature);
	});

	  // 사용자 정의 아이콘 이미지
    var bicycleIcon = new ol.style.Icon({
        src: '${contextPath}/resources/Image/bicycleIcon.png', // 이미지 파일의 경로를 설정하세요
        scale: 0.5, // 이미지의 크기를 조절합니다
        anchor: [0.5, 1], // 이미지의 기준점을 설정합니다
    });

    // Create a vector source and layer to add the features to the map
    var vectorSource = new ol.source.Vector({
        features: features,
    });

    var vectorLayer = new ol.layer.Vector({
        source: vectorSource,
        style: new ol.style.Style({
            image: bicycleIcon, // 사용자 정의 아이콘 이미지를 설정합니다
        }),
    });

    map.addLayer(vectorLayer);

    var extent = vectorSource.getExtent();
    map.getView().fit(extent, { padding: [3, 3, 3, 3] });
	}

window.onload = init;

function init(){
		map = new ol.Map({
		view : new ol.View({
			center : [0,0],
			zoom : 2
		}),
		layers : [
			//뷰, style 등을 관리하기 위해 설정한다
			new ol.layer.Tile({
				source : new ol.source.OSM()
			})
		],

		//지도를 표시할 대상의 ID
		target : 'map'
	})
}
//-------------------------내 위치 찾기 ------------------------------------------------------
getUserLocation();

function getUserLocation() {
    if (!navigator.geolocation) {
        throw "위치 정보가 지원되지 않습니다.";
    }
    navigator.geolocation.getCurrentPosition(success);
}
var longitude;//내 위치 경도
var latitude;//내 위치 위도
function success({ coords, timestamp }) {
    longitude = coords.longitude; // 경도
    latitude = coords.latitude;   // 위도
}

</script>
</head>

<body>
	<div id = "titleDiv">
	</div>
	<div id="map" class="map" style="display: block;"></div>
	<div id="cesiumContainer" class="aaa" style="display: none;"></div>
	<b><p2>[침수 위험 지역 시민 제보]</p2></b>
	<div>
		<input type="text" id="citizenFormData" name="citizenFormData" Placeholder="ex) (시/도/읍/면) 중 일부 또는 전체를 입력하세요" size="50">
		<button id="submitButton" name="submitButton">등록</button>
		<button id="reStart" onclick="location.href='${contextPath}/openLayers'";>point 반영 확인</button>
			<button id ="myLocation" style="margin-left :20px;">내 위치 찾기</button>
			<button id ="senser" style="margin-left :20px;">센서값 로드(미구현)</button>
			<button id ="oL" style="background-color:skyblue; margin-left :15px; width:200px; height:30px">openLasyersView</button>
			<button id ="Ce" style="background-color:skyblue; margin-left :2px; width:200px; height:30px">CesiumView</button>
	</div>
	<div id="aaa"></div>
	<div id="yourContainerId"></div>
	
	
	
	
	
	
	
	<!-- Cesim code start-->
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
	//  이 섹션에서는 카메라가 특정 위치로 날아가도록 애니메이션을 적용합니다.
	//  목적지는 경도, 위도, 높이 (각각 도와 미터)로 지정된 샌프란시스코로 설정됩니다.
	//  카메라 방향도 0도 방향과 피치 -90도로 설정됩니다.
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
	//세슘 부산 출연기관 통신(ready에는 작동안함. script type이 달라서 그런 것 같다.)
	$.ajax({
		url : "${contextPath}/busanList.do",
		type : "get",
		dataType : "json",
		success : busanList,
		error : function(){alert("error");}
	});

//대피소 콜백
function busanList(data3){
	//alert('부산리스트 콜백함수 실행됨');
	console.log(data3);
$.each(data3, function(index, item){
let czml = [
	  {
	    id: "document",
	    name: "CZML Point",
	    version: "1.0",
	  },
	  {
	    id: "aaa",
	    name: "부산 정부 출연 기업",
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

	  czml[1].position.cartographicDegrees = [item.lng, item.lat, 1000];

	  const dataSourcePromise = Cesium.CzmlDataSource.load(czml);
	  viewer.dataSources.add(dataSourcePromise);
	  viewer.zoomTo(dataSourcePromise);

	});// 반복문 끝
}

</script>
</body>
</html>