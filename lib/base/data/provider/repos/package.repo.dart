part of "../export.provider.dart";

class PackageRepo extends NetworkRequest {
  // create package
  Future<Package> createPackage(
      {required Package package, required List<File> images}) async {
    try {
      var requestQuerry =
          http.MultipartRequest("POST", Uri.parse("${API_URL}packages/create"));
      if (images.isNotEmpty) {
        for (var image in images) {
          final imageUrl = await geQueryFile(image: image, name: "images");
          requestQuerry.files.add(imageUrl);
        }
      }
      requestQuerry.headers.addAll(getHeader());
      final data = package.toMap();
      data.forEach((key, value) {
        if (value != null) {
          requestQuerry.fields[key] = value.toString();
        }
      });
      var response = await requestQuerry.send();
      if (response.statusCode == 201) {
        return response.stream.bytesToString().then((val) {
          final Map<String, dynamic> data = json.decode(val);
          return Package.fromMap(data['data']);
        });
      } else {
        return response.stream.bytesToString().then((val) {
          var message = json.decode(val)["message"];
          throw CustomError(message);
        });
      }
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  // update package
  Future<Package> updatePackage(
      {required Package package, required List<File> images}) async {
    try {
      var requestQuerry = http.MultipartRequest(
          "POST", Uri.parse("${API_URL}packages/edit?id=${package.id}"));
      if (images.isNotEmpty) {
        for (var image in images) {
          final imageUrl = await geQueryFile(image: image, name: "images");
          requestQuerry.files.add(imageUrl);
        }
      }
      requestQuerry.headers.addAll(getHeader());
      final data = package.toMap();
      data.forEach((key, value) {
        if (value != null) {
          requestQuerry.fields[key] = value.toString();
        }
      });
      var response = await requestQuerry.send();
      if (response.statusCode == 200) {
        return response.stream.bytesToString().then((val) {
          final Map<String, dynamic> data = json.decode(val);
          return Package.fromMap(data['package']);
        });
      } else {
        return response.stream.bytesToString().then((val) {
          log(val);
          var message = json.decode(val)["message"];
          throw CustomError(message);
        });
      }
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  // get user packages
  Future<List<Package>> getUserPackages() async {
    try {
      var response = await get("packages/my-packages");
      if (response['success'] == true) {
        List<dynamic> data = response['data'];
        return List<Package>.from(data.map((x) => Package.fromMap(x)));
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      log('Error getting user packages: $e');
      rethrow;
    }
  }

  // get package details
  Future<Package?> getPackageDetails({required int id}) async {
    try {
      var response = await get("packages/details?id=$id");
      if (response['success'] == true) {
        return Package.fromMap(response['data']);
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      log('Error getting package details: $e');
      rethrow;
    }
  }

  // deletePackage
  Future<void> deletePackage({required int id}) async {
    try {
      var response = await delete("packages/delete?id=$id");
      if (response['success'] == true) {
        return;
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      log('Error deleting package: $e');
      rethrow;
    }
  }
}

Map<String, String> getHeader() {
  return {
    'Authorization': 'Bearer ${Storage.getData("authToken")}',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "x-route-token": ROUTE_TOKEN,
  };
}

Future<http.MultipartFile> geQueryFile(
    {required File image, required String name}) async {
  var stream = http.ByteStream(image.openRead());
  var length = await image.length();
  return http.MultipartFile(
    name,
    stream,
    length,
    filename: path.basename(image.path),
    contentType: MediaType(name, path.basename(image.path).split(".").last),
  );
}
