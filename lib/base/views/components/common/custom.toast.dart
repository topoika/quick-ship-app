part of "../components.dart";

void showCustomToast(
    {required String message, String? type, String? position}) {
  Color color = Colors.grey;
  ToastGravity gravity = ToastGravity.TOP;
  if (position == "bottom") {
    gravity = ToastGravity.BOTTOM;
  } else if (position == "center") {
    gravity = ToastGravity.CENTER;
  }

  if (type == "err") {
    color = Colors.red;
  } else if (type == "suc") {
    color = Colors.green;
  }
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
