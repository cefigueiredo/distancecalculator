class RentalMap

  initMap: () ->
    @map = new google.maps.Map($('#path-coordinates')[0], {
      center: {lat: 32, lng: 1},
      zoom: 2
    })
    @polyline = new google.maps.Polyline(
      strokeColor: '#ff0000',
      strokeOpacity: 1.0,
      strokeWeight: 3,
      geodesic: true,
      map: @map,
    )
    @paths = []
    $('#path-coordinates').data('encoded-polylines').forEach (polyline) =>
      @paths = google.maps.geometry.encoding.decodePath(polyline)

    @polyline.setPath(@paths)

    $('#path-coordinates').height('500px')

$(document).on('turbolinks:load', () ->
  rentalMap = new RentalMap()
  rentalMap.initMap()

  window.rentalMap = rentalMap
)
