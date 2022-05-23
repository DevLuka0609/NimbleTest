import 'dart:math';

double getDistanceFromLatLonInKm(lat, lon) {
  var currentLat = 37.48771670017411;
  var currentLon = -122.22652739630438;
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat - currentLat) * p) / 2 +
      cos(currentLat * p) * cos(lat * p) * (1 - cos((lon - currentLon) * p)) / 2;
  return 12742 * asin(sqrt(a));
}


