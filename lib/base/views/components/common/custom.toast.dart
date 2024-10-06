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

AppBar commonAppBar(
    {required BuildContext context, String? title, Function? onBack}) {
  return AppBar(
    leadingWidth: 72,
    leading: Visibility(
      visible: onBack != null,
      replacement: const SizedBox(),
      child: GestureDetector(
        onTap: () {
          if (onBack != null) {
            onBack();
          } else {
            Navigator.pop(context);
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.horPad, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          height: 10,
          width: 10,
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
    ),
    title: TextVariation(
      text: title ?? "",
      size: 15,
      weight: FontWeight.w600,
    ),
  );
}
