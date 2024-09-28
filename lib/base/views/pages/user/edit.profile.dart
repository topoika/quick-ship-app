part of "../pages.dart";

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? image;
  File? verificationFront;
  File? verificationBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextVariation(
          text: "Update Profile",
          size: 18,
          weight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 5),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (image != null) {
                            showLargeImage(context, null, image);
                          }
                        },
                        child: Container(
                          height: context.width * .32,
                          width: context.width * .32,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover,
                                    )
                                  // : activeUser.value.imageUrl != null
                                  //     ? DecorationImage(
                                  //         image: NetworkImage(
                                  //             "${activeUser.value.imageUrl}"),
                                  //         fit: BoxFit.cover,
                                  //       )
                                  : null),
                          child: image != null
                              ? const SizedBox()
                              : const Icon(
                                  Icons.person,
                                  size: 40,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: InkWell(
                          onTap: () => showPickOptionsDialog(
                              context,
                              () => takeCroppedPicture(
                                    context,
                                    "profile",
                                    (val) => setState(() => image = File(val)),
                                  ),
                              () => loadCroppedPicture(
                                    context,
                                    "profile",
                                    (val) => setState(() => image = File(val)),
                                  ),
                              profile: true),
                          splashColor: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: context.primaryColor.withOpacity(.2),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: context.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InputFieldWidget(
                  title: "Full Name",
                  hint: "Full Name",
                  type: "name",
                  required: true,
                  init: activeUser.value.name,
                  onSaved: (val) => activeUser.value.name = val,
                ),
                InputFieldWidget(
                  hint: "Email",
                  type: "email",
                  title: "Email",
                  required: true,
                  init: activeUser.value.email,
                  onSaved: (val) => activeUser.value.email = val,
                ),
                PhoneInputField(
                  hint: "Phone Number",
                  disabled: false,
                  onSaved: (val) => activeUser.value.phone = val,
                  init: activeUser.value.phone?.replaceAll("+254", ""),
                ),
                InputFieldWidget(
                  title: "ID Number",
                  hint: "ID/Passport Number",
                  type: "id_number",
                  required: true,
                  init: activeUser.value.idNumber,
                  onSaved: (val) => activeUser.value.idNumber = val,
                ),
                const SizedBox(height: 15),
                const TextVariation(
                  text: "Upload Verification Documents",
                  weight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: context.height * 0.13,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(.2),
                                image: verificationFront != null
                                    ? DecorationImage(
                                        image: FileImage(verificationFront!),
                                        fit: BoxFit.cover,
                                      )
                                    : activeUser.value.verificationFront != null
                                        ? DecorationImage(
                                            image: NetworkImage(activeUser
                                                    .value.verificationFront ??
                                                ""),
                                            fit: BoxFit.fill,
                                          )
                                        : null),
                            child: verificationFront != null ||
                                    activeUser.value.verificationFront != null
                                ? const SizedBox()
                                : Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.upload,
                                          color: context.primaryColor),
                                      const SizedBox(height: 15),
                                      TextVariation(
                                        text: "Upload Verification Front",
                                        size: 12,
                                        align: TextAlign.center,
                                        weight: FontWeight.w500,
                                        color: context.primaryColor,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: context.height * 0.13,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(.2),
                                image: verificationBack != null
                                    ? DecorationImage(
                                        image: FileImage(verificationBack!),
                                        fit: BoxFit.cover,
                                      )
                                    : activeUser.value.verificationBack != null
                                        ? DecorationImage(
                                            image: NetworkImage(activeUser
                                                    .value.verificationBack ??
                                                ""),
                                            fit: BoxFit.fill,
                                          )
                                        : null),
                            child: verificationBack != null ||
                                    activeUser.value.verificationBack != null
                                ? const SizedBox()
                                : Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.upload,
                                          color: context.primaryColor),
                                      const SizedBox(height: 15),
                                      TextVariation(
                                        text: "Upload Verification Back",
                                        size: 12,
                                        weight: FontWeight.w500,
                                        align: TextAlign.center,
                                        color: context.primaryColor,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  text: "Update",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Navigator.pop(context);
                      // context.read<UserCubit>().updateUser(activeUser.value);
                    } else {
                      if (validationErrors.isNotEmpty) {
                        showCustomToast(
                          message: validationErrors[0],
                          type: "err",
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
