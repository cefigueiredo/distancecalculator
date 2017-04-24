class RentalMap

  initMap: (elem) ->
    @map = new google.maps.Map(elem, {
      center: {lat: 32, lng: 1},
      zoom: 2
    })
    @polylines = []
    $('#path-coordinates').data('encoded-polylines').forEach (polyline) =>
      polyline = new google.maps.Polyline(
        strokeColor: '#ff0000',
        strokeOpacity: 1.0,
        strokeWeight: 3,
        geodesic: true,
        map: @map,
        path: google.maps.geometry.encoding.decodePath(polyline)
      )
      @polylines.push(polyline)


$(document).on('turbolinks:load', () ->
  pathCoordinates = document.getElementById('path-coordinates')

  if pathCoordinates
    rentalMap = new RentalMap()
    rentalMap.initMap(pathCoordinates)
    $('#path-coordinates').height('500px')

    window.rentalMap = rentalMap
)
