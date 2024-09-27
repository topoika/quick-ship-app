part of "../data.dart";

class CustomError implements Exception {
  final String message;
  final int? errorCode;

  CustomError(this.message, {this.errorCode});

  @override
  String toString() {
    if (_isNetworkError(message)) {
      return "Please check your internet connection and try again.";
    }
    if (errorCode != null) {
      return '$message (Error Code: $errorCode)';
    }
    return message;
  }

  // Method to check if the message contains network-related errors
  bool _isNetworkError(String message) {
    return message.contains("HandshakeException") ||
        message.contains("SocketException") ||
        message.contains("NetworkException") ||
        message.contains("ConnectionException");
  }
}
