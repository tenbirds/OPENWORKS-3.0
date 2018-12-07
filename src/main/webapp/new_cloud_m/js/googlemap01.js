      function initialize() {
        var mapLocation = new google.maps.LatLng('35.881056', '128.730804'); // 지도에서 가운데로 위치할 위도와 경도 
        var markLocation = new google.maps.LatLng('35.881056', '128.730804'); // 마커가 위치할 위도와 경도

        var mapOptions = {
          center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
          zoom: 18, // 지도 zoom단계
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById("map-canvas"), // id: map-canvas, body에 있는 div태그의 id와 같아야 함
            mapOptions);         

        var size_x = 50; // 마커로 사용할 이미지의 가로 크기
        var size_y = 50; // 마커로 사용할 이미지의 세로 크기
         

		  // 마커로 사용할 이미지 주소
		   var image = '/new_cloud_m/images/sub/icon-map.png';
		  var myLatLng = new google.maps.LatLng(-35.881056, 128.730804);
		  var beachMarker = new google.maps.Marker({
			  position: myLatLng,
			  map: map,
			  icon: image
		  });
		 

        var marker;

        marker = new google.maps.Marker({ 
               position: markLocation, // 마커가 위치할 위도와 경도(변수)
               map: map,
               icon: image, // 마커로 사용할 이미지(변수)
//             info: '말풍선 안에 들어갈 내용',
               title: '한국정보화진흥원' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
        });         

        var content = "한국정보화진흥원<br />Tel : 053-230-1114"; // 말풍선 안에 들어갈 내용
         

        // 마커를 클릭했을 때의 이벤트. 말풍선 나옴
        var infowindow = new google.maps.InfoWindow({ content: content}); 

        google.maps.event.addListener(marker, "click", function() {
            infowindow.open(map,marker);
        });         

      }

      google.maps.event.addDomListener(window, 'load', initialize);