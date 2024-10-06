part of "../components.dart";

final filePicker = ImagePicker();

Widget buildOptionItem({
  required BuildContext context,
  required IconData icon,
  required String label,
  required Function() onTap,
  Color textColor = Colors.black,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: context.width * 0.06,
          ),
          const SizedBox(width: 15),
          Text(
            label,
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}

void showPickOptionsDialog(BuildContext context, cam, gal, {profile = true}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (profile)
              buildOptionItem(
                context: context,
                icon: Icons.photo,
                label: "Gallery",
                onTap: gal,
              ),
            buildOptionItem(
              context: context,
              icon: Icons.camera,
              label: "Camera",
              onTap: cam,
            ),
            buildOptionItem(
              context: context,
              icon: Icons.cancel,
              label: "Cancel",
              onTap: () => Navigator.of(context).pop(),
              textColor: Colors.redAccent,
            ),
          ],
        ),
      );
    },
  );
}

cropImage(File picked, context, onsaved, type) async {
  final cropped = await ImageCropper().cropImage(
    sourcePath: picked.path,
    aspectRatio: CropAspectRatio(
      ratioX: 400,
      ratioY: getAspectY(type),
    ),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: AppStrings.appName,
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Colors.black,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: '${AppStrings.appName} Cropper',
      ),
    ],
    maxWidth: 400,
  );
  if (cropped != null) {
    onsaved(cropped.path);
  }
}

double getAspectY(type) {
  switch (type) {
    case "profile":
      return 400;
    case "document":
      return 300;
    default:
      return 25;
  }
}

void loadCroppedPicture(context, type, onSaved) async {
  final pickedFile = await filePicker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 100);
  cropImage(File(pickedFile!.path), context, onSaved, type);
  Navigator.pop(context);
}

void takeCroppedPicture(context, type, onSaved) async {
  final pickedFile = await filePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 100);
  cropImage(File(pickedFile!.path), context, onSaved, type);
  Navigator.pop(context);
}

Future<File> takeCarImage(context) async {
  final pickedFile = await filePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100);
  Navigator.pop(context);

  return File(pickedFile!.path);
}

Future<File> takePackageImage(context) async {
  final pickedFile = await filePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100);
  Navigator.pop(context);

  return File(pickedFile!.path);
}

Future<List<File>> loadImages(context) async {
  List<File> files = [];
  final pickedImages = await filePicker.pickMultiImage(imageQuality: 100);
  for (var file in pickedImages) {
    files.add(File(file.path));
  }
  Navigator.pop(context);
  return files;
}

showLargeImage(context, img, fl) => showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: userImage(context, img, fl),
        );
      },
    );

Widget userImage(context, image, File? fl) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      width: double.maxFinite,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: fl != null
            ? DecorationImage(
                image: FileImage(fl),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
      ),
    );
