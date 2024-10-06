part of "../export.provider.dart";

class TripRepo extends NetworkRequest {
  // create a trip
  Future<Trip> createTrip({required Trip trip}) async {
    try {
      final response = await post("trips/create", trip.toMap());
      log(response.toString());
      if (response['status'] == false) {
        throw CustomError(response['message']);
      } else {
        return Trip.fromMap(response['data']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // get user trips
  Future<List<Trip>> getUserTrips() async {
    try {
      final response = await get("trips/my-trips");
      if (response['status'] == false) {
        throw CustomError(response['message']);
      } else {
        List<dynamic> data = response['data'];
        return List<Trip>.from(data.map((trip) => Trip.fromMap(trip)));
      }
    } catch (e) {
      rethrow;
    }
  }

  // get user trips
  Future<List<Trip>> getRouteTrips(
      {required Address destination, required Address departure}) async {
    Map<String, dynamic> body = {
      "destination": {
        "latitude": destination.latitude,
        "longitude": destination.longitude,
        "name": destination.nameAddress
      },
      "departure": {
        "latitude": departure.latitude,
        "longitude": departure.longitude,
        "name": departure.nameAddress
      }
    };
    try {
      final response = await post("trips/route-trips", body);
      if (response['status'] == false) {
        throw CustomError(response['message']);
      } else {
        List<dynamic> data = response['data'];
        return List<Trip>.from(data.map((trip) => Trip.fromMap(trip)));
      }
    } catch (e) {
      rethrow;
    }
  }

  // get trip details
  Future<Trip> getTripDetails({required int id}) async {
    try {
      final response = await get("trips/details?id=$id");
      if (response['status'] == false) {
        throw CustomError(response['message']);
      } else {
        return Trip.fromMap(response['data']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // delete trip
  Future<void> deleteTrip({required int id}) async {
    try {
      final response = await delete("trips/delete?id=$id");
      if (response['status'] == false) {
        throw CustomError(response['message']);
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }
}
