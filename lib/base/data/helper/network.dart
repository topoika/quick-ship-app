part of "../data.dart";

class NetworkRequest {
  final Connectivity connectivity = Connectivity();

  Map<String, String> getFormHeaders() => {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Storage.getData("authToken")}',
        "x-route-token": ROUTE_TOKEN,
      };

  Map<String, String> getJsonHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Storage.getData("authToken")}',
      "x-route-token": ROUTE_TOKEN,
    };
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    await _checkConnectivity();
    final response = await http
        .get(Uri.parse('$API_URL$endpoint'),
            headers: headers ?? getJsonHeaders())
        .onError((error, stackTrace) => throw CustomError(error.toString()));
    return _parseResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic data,
      {Map<String, String>? headers}) async {
    await _checkConnectivity();
    final response = await http
        .post(
          Uri.parse('$API_URL$endpoint'),
          body: json.encode(data),
          headers: headers ?? getJsonHeaders(),
        )
        .onError((error, stackTrace) => throw CustomError(error.toString()));
    return _parseResponse(response);
  }

  Future<dynamic> put(String endpoint, dynamic data,
      {Map<String, String>? headers}) async {
    await _checkConnectivity();
    final response = await http
        .put(
          Uri.parse('$API_URL$endpoint'),
          body: json.encode(data),
          headers: headers ?? getJsonHeaders(),
        )
        .onError((error, stackTrace) => throw CustomError(error.toString()));
    return _parseResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    await _checkConnectivity();
    final response = await http
        .delete(Uri.parse('$API_URL$endpoint'), headers: getJsonHeaders())
        .onError((error, stackTrace) => throw CustomError(error.toString()));
    return _parseResponse(response);
  }

  dynamic _parseResponse(http.Response response) {
    final body = json.decode(response.body);
    String message = body['message'] ?? "";
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else if (body['success'] == false) {
      throw CustomError(message);
    } else {
      throw CustomError("Error");
    }
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw CustomError('No internet connection');
    }
  }
}
