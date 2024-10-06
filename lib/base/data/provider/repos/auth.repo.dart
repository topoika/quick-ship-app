part of "../export.provider.dart";

ValueNotifier<User> activeUser = ValueNotifier<User>(User());

class AuthRepo extends NetworkRequest {
  // request Email Otp
  Future<String?> requestEmailOtp() async {
    try {
      final response =
          await post("auth/send-email-otp", {}, headers: getJsonHeaders());
      if (response['data']['otp'] != null) {
        String otp = response['data']['otp'];
        return otp;
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // verify Email Otp
  Future<User?> verifyEmailOtp({required String otp}) async {
    try {
      final response = await post("auth/verify-email", {"otp": otp});
      if (response['user'] != null) {
        activeUser.value = User.fromMap(response['user']);
        return activeUser.value;
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // get user
  Future<User?> getUser() async {
    try {
      final response = await get("user/info");
      if (response['user'] != null) {
        activeUser = ValueNotifier(User.fromMap(response['user']));
        // await fcm.subscribeToTopic("user_${activeUser.value.id}");
        return activeUser.value;
      } else {
        throw CustomError("User not found");
      }
    } catch (e) {
      rethrow;
    }
  }

  // loginUser
  Future<User?> loginUser({required User user}) async {
    try {
      final response = await post("auth/login", activeUser.value.toMap());
      if (response['user'] != null && response['auth_token'] != null) {
        activeUser = ValueNotifier(User());
        activeUser.value = User.fromMap(response['user']);
        // await fcm.subscribeToTopic("user_${activeUser.value.id}");
        Storage.saveData("authToken", response['auth_token']);
        return activeUser.value;
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // loginUser
  Future<String?> registerUser({required User user}) async {
    try {
      final response = await post("auth/register", activeUser.value.toMap());
      if (response['user'] != null &&
          response['auth_token'] != null &&
          response['otp'] != null) {
        activeUser = ValueNotifier(User());
        activeUser.value = User.fromMap(response['user']);
        Storage.saveData("authToken", response['auth_token']);
        return response['otp'];
      } else {
        log(response.toString());
        throw CustomError(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // deleteUser
  Future<void> deleteUser() async {
    try {
      final response = await delete("user/delete-account");
      if (response['success'] == true) {
        // await auth.signOut();
        // await googleSignIn.signOut();
        // await fcm.unsubscribeFromTopic("user_${activeUser.value.id}");
        activeUser.value = User();
        Storage.deleteData("authToken");
        return;
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // logout
  Future<void> logout() async {
    try {
      // await auth.signOut();
      // await googleSignIn.signOut();
      activeUser.value = User();
      // await fcm.unsubscribeFromTopic("user_${activeUser.value.id}");
      Storage.deleteData("authToken");
    } catch (e) {
      rethrow;
    }
  }

  // reset password
  Future<String> requestPassWordReset({required String email}) async {
    try {
      final response =
          await post("auth/request-password-reset", {"email": email});
      if (response['success'] == true) {
        return response['data']['otp'];
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future resetPassword({required String otp, required String password}) async {
    try {
      final response = await post("auth/reset-password",
          {"otp": otp, "password": password, "email": activeUser.value.email});
      if (response['success'] == true) {
        return;
      } else {
        throw CustomError(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
