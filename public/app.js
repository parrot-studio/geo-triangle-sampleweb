var GoogleMapView;
GoogleMapView = (function() {
  function GoogleMapView(center, coordinates) {
    this.center = center;
    this.coordinates = coordinates;
  }
  GoogleMapView.prototype.markers = function() {
    var list, m, ms, _i, _len;
    list = [this.center, [this.coordinates[0], this.coordinates[1]], [this.coordinates[2], this.coordinates[3]], [this.coordinates[4], this.coordinates[5]]];
    ms = [];
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      m = list[_i];
      ms.push({
        latitude: m[0],
        longitude: m[1]
      });
    }
    return ms;
  };
  GoogleMapView.prototype.params = function() {
    var para;
    para = {
      latitude: this.center[0],
      longitude: this.center[1],
      zoom: 12,
      markers: this.markers()
    };
    return para;
  };
  GoogleMapView.prototype.view = function(target) {
    return $(target).gMap(this.params());
  };
  return GoogleMapView;
})();