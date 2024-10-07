part of "../export.provider.dart";

class PackageRequestRepo extends NetworkRequest {
  // create package request
  Future<PackageRequest> createPackageRequest(
      {required int packageId, required int tripId}) async {
    try {
      final response = await post(
          "request/create", {"packageId": packageId, "tripId": tripId});
      if (response['success'] == true) {
        final packageRequest = PackageRequest.fromMap(response['data']);
        return packageRequest;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // fetch package requests
  Future<List<PackageRequest>> fetchPackageRequests({required int id}) async {
    try {
      final response = await get("request/package-requests?id=$id");
      if (response['success'] == true) {
        final packageRequests = response['data']
            .map<PackageRequest>((e) => PackageRequest.fromMap(e))
            .toList();
        return packageRequests;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // accept package request
  Future acceptPackageRequest({required int id}) async {
    try {
      final response = await put("request/accept?id=$id", {});
      log("Response $response");
      if (response['success'] == true) {
        return;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // decline package request
  Future declinePackageRequest({required int id}) async {
    try {
      final response = await put("request/reject?id=$id", {});
      if (response['success'] == true) {
        return;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // delete package request
  Future<void> deletePackageRequest({required int id}) async {
    try {
      final response = await delete("request/delete?id=$id");
      if (response['success'] == true) {
        return;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // fetch package request details
  Future<PackageRequest> fetchPackageRequestDetails({required int id}) async {
    try {
      final response = await get("request/details?id=$id");
      if (response['success'] == true) {
        final packageRequest = PackageRequest.fromMap(response['data']);
        return packageRequest;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
