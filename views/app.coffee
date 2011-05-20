class GoogleMapView
  constructor: (@center, @coordinates) ->
  
  markers: ->
    list = [
      @center,
      [@coordinates[0], @coordinates[1]],
      [@coordinates[2], @coordinates[3]],
      [@coordinates[4], @coordinates[5]],
    ]
    ms = []
    for m in list
      ms.push {latitude: m[0], longitude: m[1]}
    ms
  
  params: ->
    para =
      latitude: @center[0]
      longitude: @center[1]
      zoom: 12
      markers: this.markers()
    para
  
  view: (target) ->
    $(target).gMap(this.params())
