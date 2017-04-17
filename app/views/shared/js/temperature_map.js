var map, heatmap;

window.initMap = function() {
  alert("HUI PIZDA DJIGURDA 2");

  map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 10,
    mapTypeControl: false,

    mapTypeId: 'roadmap'
  });

  drawHeatMap();
}

function toggleHeatmap() {
  heatmap.setMap(heatmap.getMap() ? null : map);
}

function changeGradient() {
  var gradient = [
    'rgba(0, 255, 255, 0)',
    'rgba(0, 255, 255, 1)',
    'rgba(0, 191, 255, 1)',
    'rgba(0, 127, 255, 1)',
    'rgba(0, 63, 255, 1)',
    'rgba(0, 0, 255, 1)',
    'rgba(0, 0, 223, 1)',
    'rgba(0, 0, 191, 1)',
    'rgba(0, 0, 159, 1)',
    'rgba(0, 0, 127, 1)',
    'rgba(63, 0, 91, 1)',
    'rgba(127, 0, 63, 1)',
    'rgba(191, 0, 31, 1)',
    'rgba(255, 0, 0, 1)'
  ]
  heatmap.set('gradient', heatmap.get('gradient') ? null : gradient);
}

function changeRadius() {
  heatmap.set('radius', heatmap.get('radius') ? null : 20);
}

function changeOpacity() {
  heatmap.set('opacity', heatmap.get('opacity') ? null : 0.2);
}

function getPeriod() {
  drawHeatMap();
}

function drawHeatMap() {
  var start_date = document.getElementById('start_datepicker');
  var end_date = document.getElementById('end_datepicker');

  if (heatmap == null) {
    heatmap = new google.maps.visualization.HeatmapLayer();
  }

  heatmap.setMap(null);
  heatmap.setMap(map);
  heatmap.setData(getPoints(start_date.value, end_date.value));
}

function getPoints(start_date, end_date) {
  var points = [];

  $.ajax({
    type: 'GET',
    data: {
      start_date: start_date,
      end_date: end_date
    },
    url: '/api/temperature_map',
    async: true,
    beforeSend: function (xhr) {
      if (xhr && xhr.overrideMimeType) {
        xhr.overrideMimeType('application/json;charset=utf-8');
      }
    },
    dataType: 'json',
    success: function (data) {
      var arrayLength = data.length;
      for (var i = 0; i < arrayLength; i++) {
          points.push(new google.maps.LatLng(data[i].latitude, data[i].longitude));
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(textStatus + ': ' + errorThrown);
    }
  });

  return points
}
