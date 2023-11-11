import 'dart:math';

class Location {
  double latitude;
  double longitude;

  Location(this.latitude, this.longitude);


}



// Calculate the distance between two locations using the Haversine formula
double calculateDistance(Location location1, Location location2) {
  const double earthRadius = 6371; // Earth's radius in kilometers

  // Convert latitude and longitude from degrees to radians
  double lat1 = location1.latitude * (pi / 180);
  double lon1 = location1.longitude * (pi / 180);
  double lat2 = location2.latitude * (pi / 180);
  double lon2 = location2.longitude * (pi / 180);

  // Haversine formula
  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c; // Distance in kilometers

  return distance;
}