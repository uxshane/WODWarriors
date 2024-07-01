<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   
   <style>
      /* 화면 중앙 정렬을 위한 CSS */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* 뷰포트 높이를 100%로 설정 */
            margin: 0; /* 기본 마진 제거 */
            background-color: #f0f0f0; /* 배경 색상 (선택 사항) */
        }
        
   </style>
   
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${ appKey }&libraries=services,clusterer"></script>
   <script>
   		
   		var geocoder = new kakao.maps.services.Geocoder();
		var posts = ${posts};
		var listdata = [];
		
		posts.forEach(function(post) {
			listdata.push(post.location);
		});
		
	     // listData를 이용하여 지도에 마커 표시
        listdata.forEach(function(addr, index) {
        	console.log(addr);
            geocoder.addressSearch(addr, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:6px 0;">' + addr + '</div>',
                        disableAutoPan: true
                    });

                    infowindow.open(map, marker);
                }
            });
        });
   
   </script>

</head>
   
<body>

   <div id="map" style="width: 800px; height: 600px;"></div>
   
   <script type="text/javascript">
	   // Chrome 보안 강화 정책에 따른 서드파티 쿠키 허용
	   document.cookie = 'cookie2=value2; SameSite=None; Secure';
	
	   // -- 변수 선언 --
	   let container = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스
	   let options = { // 지도를 생성할 때 필요한 기본 옵션
	       center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표.
	       level: 12 // 지도의 레벨(확대, 축소 정도)
	   };
	
	   let map = new kakao.maps.Map(container, options); // 지도 생성 및 객체 리턴
	   let customOverlay = new kakao.maps.CustomOverlay({});
	   let detailMode = false; // level에 따라 다른 json 파일 사용
	   let level = '';
	   let polygons = [];
	   let areas = []; // areas 변수를 전역으로 선언하여 참조 가능하게 함
	   // -- 변수 선언 끝 --
	
	   init("resources/json/sido.json"); // 초기 시작
	
	   kakao.maps.event.addListener(map, 'zoom_changed', function() {
	       level = map.getLevel();
	       console.log(level);
	       if (!detailMode && level <= 10) { // level에 따라 다른 json 파일을 사용한다.
	           detailMode = true;
	           removePolygon();
	           init("resources/json/sig.json");
	       } else if (detailMode && level > 10) { // level에 따라 다른 json 파일을 사용한다.
	           detailMode = false;
	           removePolygon();
	           init("resources/json/sido.json");
	       }
	   });
	
	   // 모든 폴리곤을 지우는 함수
	   function removePolygon() {
	       for (let i = 0; i < polygons.length; i++) {
	           polygons[i].setMap(null);
	       }
	       areas = [];
	       polygons = [];
	   }
	   
	   // 폴리곤의 중심을 계산하는 함수
	   function getPolygonCenter(path) {
	       let minLat = path[0].getLat();
	       let maxLat = path[0].getLat();
	       let minLng = path[0].getLng();
	       let maxLng = path[0].getLng();
	
	       path.forEach(function(latlng) {
	           if (latlng.getLat() < minLat) minLat = latlng.getLat();
	           if (latlng.getLat() > maxLat) maxLat = latlng.getLat();
	           if (latlng.getLng() < minLng) minLng = latlng.getLng();
	           if (latlng.getLng() > maxLng) maxLng = latlng.getLng();
	       });
	
	       let centerLat = (minLat + maxLat) / 2;
	       let centerLng = (minLng + maxLng) / 2;
	
	       return new kakao.maps.LatLng(centerLat, centerLng);
	   }
	   
	   // 폴리곤 생성
	   function init(path) {
	       // path 경로의 json 파일 파싱
	       fetch(path)
	           .then(response => response.json())
	           .then(geojson => {
	               var units = geojson.features; // json key값이 "features"인 것의 value를 통으로 가져온다.
	
	               units.forEach((unit, index) => { // 1개 지역씩 꺼내서 사용. unit은 그 1개 지역에 대한 정보를 담는다
	                   var coordinates = []; // 좌표 저장할 배열
	                   var name = ''; // 지역 이름
	                   var cd_location = '';
	
	                   if (unit.properties) {
	                       coordinates = unit.geometry.coordinates; // 1개 지역의 영역을 구성하는 다각형의 모든 좌표 배열
	                       name = unit.properties.SIG_KOR_NM || unit.properties.CTP_KOR_NM; // 1개 지역의 이름
	
	                       if (path.includes("sido.json")) {
	                           cd_location = unit.properties.CTPRVN_CD;
	                       } else if (path.includes("sig.json")) {
	                           cd_location = unit.properties.SIG_CD;
	                       }
	
	                       var ob = {
	                           name: name,
	                           path: [],
	                           location: cd_location
	                       };
	
	                       coordinates[0].forEach(coordinate => {
	                           ob.path.push(new kakao.maps.LatLng(coordinate[1], coordinate[0]));
	                       });
	
	                       areas[index] = ob;
	                   } else {
	                       console.error("CTPRVN_CD or SIG_CD not found in unit.properties");
	                   }
	               });
	
	               // 지도에 영역데이터를 폴리곤으로 표시
	               for (var i = 0, len = areas.length; i < len; i++) {
	                   displayArea(areas[i]);
	               }
	           })
	           .catch(error => console.error('Error fetching JSON:', error));
	   }
	
	   function displayArea(area) {
	       var polygon = new kakao.maps.Polygon({
	           map: map,
	           path: area.path,
	           strokeWeight: 2,
	           strokeColor: '#004c80',
	           strokeOpacity: 0.8,
	           fillColor: '#fff',
	           fillOpacity: 0.3
	       });
	       polygons.push(polygon);
	       
	       var center = getPolygonCenter(area.path); // 폴리곤의 중심 계산
	
	       kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
	           polygon.setOptions({ fillColor: '#09f' });
	           /* customOverlay.setContent('<div class="area">' + area.name + '</div>'); */
	           customOverlay.setPosition(mouseEvent.latLng);
	           customOverlay.setMap(map);
	       });
	
	       kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
	           customOverlay.setPosition(mouseEvent.latLng);
	       });
	
	       kakao.maps.event.addListener(polygon, 'mouseout', function() {
	           polygon.setOptions({ fillColor: '#fff' });
	           customOverlay.setMap(null);
	       });
	
	       kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
	           if (!detailMode) {
	               map.setLevel(10); // level에 따라 이벤트 변경
	               var latlng = mouseEvent.latLng;
	             
	               // 지도의 중심을 부드럽게 클릭한 위치로 이동시킵니다.
	               map.panTo(latlng);
	           } else {
	               // 클릭 이벤트 함수
	               // callFunctionWithRegionCode(area.location);
	               map.setLevel(level); // level에 따라 이벤트 변경
	               map.panTo(center); // 클릭한 폴리곤의 중심을 지도 중심으로 설정
	           }
	       });
	   }
   </script>
   
</body>
</html>














