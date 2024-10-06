part of "../export.provider.dart";

class UserRepo extends NetworkRequest {
  // update profile
  Future<User> updateProfile(
      {required User user,
      File? image,
      File? verificationFront,
      File? verificationBack}) async {
    try {
      var requestQuerry = http.MultipartRequest(
          "PUT", Uri.parse("${API_URL}user/update-profile"));
      if (image != null) {
        final file = await geQueryFile(image: image, name: "image");
        requestQuerry.files.add(file);
      }
      if (verificationFront != null) {
        final file = await geQueryFile(
            image: verificationFront, name: "verificationFront");
        requestQuerry.files.add(file);
      }
      if (verificationBack != null) {
        final file = await geQueryFile(
            image: verificationBack, name: "verificationBack");
        requestQuerry.files.add(file);
      }
      requestQuerry.headers.addAll(getHeader());
      final data = user.toUpdateMap();
      data.forEach((key, value) {
        if (value != null) {
          requestQuerry.fields[key] = value.toString();
        }
      });

      var response = await requestQuerry.send();
      if (response.statusCode == 200) {
        return response.stream.bytesToString().then((val) {
          final Map<String, dynamic> data = json.decode(val);
          activeUser.value = User.fromMap(data['user']);
          return activeUser.value;
        });
      } else {
        return response.stream.bytesToString().then((val) {
          var message = json.decode(val)["message"];
          throw CustomError(message);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  // user stats
  Future<UserWallet> fetchUserStats() async {
    try {
      final response = await get('data/home-user-stats');
      if (response['success'] == true) {
        return UserWallet.fromMap(response['data']);
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
