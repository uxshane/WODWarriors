<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>운동 지도보기</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<style>
body {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    margin: 0;
    background-color: #f5f7fa;
    font-family: 'Roboto', sans-serif;
    padding: 20px 0;
}

#map {
    width: 1000px;
    height: 600px;
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: relative;
}

.button-container {
    position: absolute;
    top: 20px; /* 지도의 위쪽에 위치 */
    z-index: 10; /* 지도보다 앞에 위치하도록 설정 */
    display: flex;
    justify-content: center;
    width: 100%;
}

.button-container button {
    margin: 0 5px;
    padding: 10px 20px;
    cursor: pointer;
    border: none;
    border-radius: 5px;
    background-color: #007bff;
    color: white;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.button-container button:hover {
    background-color: #0056b3;
}

.footer-container {
    width: 1000px;
    display: flex;
    justify-content: center;
    position: relative;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
    text-align: center;
}
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${ appKey }&libraries=services,clusterer"></script>
<script>
var userIdx = ${userIdx};
var geocoder = new kakao.maps.services.Geocoder();
var posts = JSON.parse('${posts}');
var openInfowindow = null;
var markers = [];

posts.forEach(function(post) {
    var addr = post.location;
    var content = '<div style="width:200px;text-align:center;padding:10px 0;">' +
    '<h4>' + post.title + '</h4>' +
    '<p>' + post.description + '</p>' +
    '<p>' + post.startdate + ' ' + post.starttime + '</p>' +
    '<p>위치: ' + post.location + '</p>' +
    '<button onclick="navigateToPostDetail(' + userIdx + ', ' + post.idx + ')">참여하기</button>' +
    '</div>';

    var optionId = parseInt(post.exercise_option_id, 10);
    var imageSrc;
    if (optionId >= 1 && optionId <= 3) {
        imageSrc = (userIdx === post.user_idx) ? 'resources/images/my_running.png' : 'resources/images/your_running.png';
    } else if (optionId >= 4 && optionId <= 5) {
        imageSrc = (userIdx === post.user_idx) ? 'resources/images/my_weightlifting.png' : 'resources/images/your_weightlifting.png';
    } else if (optionId >= 6 && optionId <= 8) {
        imageSrc = (userIdx === post.user_idx) ? 'resources/images/my_yoga.png' : 'resources/images/your_yoga.png';
    } else if (optionId >= 9 && optionId <= 11) {
        imageSrc = (userIdx === post.user_idx) ? 'resources/images/my_hiking.png' : 'resources/images/your_hiking.png';
    }

    var imageSize = new kakao.maps.Size(54, 69);
    var imageOption = {offset: new kakao.maps.Point(27, 69)};

    geocoder.addressSearch(addr, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

            var marker = new kakao.maps.Marker({
                map: map,
                position: coords,
                image: markerImage
            });

            var markerType = (userIdx === post.user_idx) ? 'my' : 'your';
            marker.type = markerType;

            var infowindow = new kakao.maps.InfoWindow({
                content: content,
                disableAutoPan: true
            });

            kakao.maps.event.addListener(marker, 'mouseover', function() {
                if (openInfowindow !== infowindow) {
                    infowindow.open(map, marker);
                }
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                if (openInfowindow !== infowindow) {
                    infowindow.close();
                }
            });

            kakao.maps.event.addListener(marker, 'click', function() {
                if (openInfowindow === infowindow) {
                    infowindow.close();
                    openInfowindow = null;
                } else {
                    if (openInfowindow) {
                        openInfowindow.close();
                    }
                    infowindow.open(map, marker);
                    openInfowindow = infowindow;
                    map.panTo(coords);
                }
            });

            markers.push(marker);
        }
    });
});

function navigateToPostDetail(userIdx, postIdx) {
    var url = 'post_detail.do?userIdx=' + userIdx + '&postIdx=' + postIdx;
    window.location.href = url;
}

function setMarkers(type) {
    for (var i = 0; i < markers.length; i++) {
        if (markers[i].type === type || type === 'all') {
            markers[i].setMap(map);
        } else {
            markers[i].setMap(null);
        }
    }
}

function showMyMarkers() {
    setMarkers('my');
}

function showYourMarkers() {
    setMarkers('your');
}
</script>

</head>

<body>

<div id="map">
    <div class="button-container">
        <button onclick="showMyMarkers()">내 게시물</button>
        <button onclick="showYourMarkers()">네 게시물</button>
        <button onclick="setMarkers('all')">모두 보기</button>
    </div>
</div>	

<jsp:include page="footer.jsp"/>

<script type="text/javascript">
    document.cookie = 'cookie2=value2; SameSite=None; Secure';

    let container = document.getElementById('map');
    let options = {
        center: new kakao.maps.LatLng(37.2747, 127.4472),
        level: 12
    };

    let map = new kakao.maps.Map(container, options);
    let customOverlay = new kakao.maps.CustomOverlay({});
    let detailMode = false;
    let level = '';
    let polygons = [];
    let areas = [];

    init("resources/json/sido.json");

    kakao.maps.event.addListener(map, 'zoom_changed', function() {
        level = map.getLevel();
        if (!detailMode && level <= 10) {
            detailMode = true;
            removePolygon();
            init("resources/json/sig.json");
        } else if (detailMode && level > 10) {
            detailMode = false;
            removePolygon();
            init("resources/json/sido.json");
        }
    });

    function removePolygon() {
        for (let i = 0; i < polygons.length; i++) {
            polygons[i].setMap(null);
        }
        areas = [];
        polygons = [];
    }

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

    function init(path) {
        fetch(path)
            .then(response => response.json())
            .then(geojson => {
                var units = geojson.features;

                units.forEach((unit, index) => {
                    var coordinates = [];
                    var name = '';
                    var cd_location = '';

                    if (unit.properties) {
                        coordinates = unit.geometry.coordinates;
                        name = unit.properties.SIG_KOR_NM || unit.properties.CTP_KOR_NM;

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
       
        var center = getPolygonCenter(area.path);

        kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
            polygon.setOptions({ fillColor: '#09f' });
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
                map.setLevel(10);
                var latlng = mouseEvent.latLng;
                map.panTo(latlng);
            } else {
                map.setLevel(level-1);
                map.panTo(center);
            }
        });
    }
</script>

</body>
</html>
