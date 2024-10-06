// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../pages.dart";

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? image;
  File? verificationFront;
  File? verificationBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 72,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: context.horPad, vertical: 7),
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
        title: const TextVariation(
          text: "Update Profile",
          size: 15,
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
                                : activeUser.value.image != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            "${activeUser.value.image}"),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                          ),
                          child: image != null || activeUser.value.image != null
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
                  readOnly: true,
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
                  readOnly: activeUser.value.verified,
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
                        child: DocItemWidget(
                          text: "Upload Verification Front",
                          url: activeUser.value.verificationFront,
                          image: verificationFront,
                          onTap: () {
                            showPickOptionsDialog(
                              context,
                              () => takeCroppedPicture(
                                context,
                                "document",
                                (val) => setState(
                                    () => verificationFront = File(val)),
                              ),
                              () => loadCroppedPicture(
                                context,
                                "document",
                                (val) => setState(
                                    () => verificationFront = File(val)),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: DocItemWidget(
                          text: "Upload Verification Back",
                          url: activeUser.value.verificationBack,
                          image: verificationBack,
                          onTap: () {
                            showPickOptionsDialog(
                              context,
                              () => takeCroppedPicture(
                                context,
                                "document",
                                (val) => setState(
                                    () => verificationBack = File(val)),
                              ),
                              () => loadCroppedPicture(
                                context,
                                "document",
                                (val) => setState(
                                    () => verificationBack = File(val)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                BlocListener<UserBloc, UserStates>(
                  listener: (context, state) {
                    if (state is UserError) {
                      showCustomToast(message: state.message, type: "err");
                    } else if (state is UserUpdateSuccess) {
                      showCustomToast(
                          message: "Update Successful, wait for verification",
                          type: "suc");
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.tabs, (route) => false);
                    }
                  },
                  child: BlocBuilder<UserBloc, UserStates>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "Update",
                        loading: state is UserLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<UserBloc>().add(UpdateProfile(
                                  user: activeUser.value,
                                  image: image,
                                  verificationFront: verificationFront,
                                  verificationBack: verificationBack,
                                ));
                          } else {
                            if (validationErrors.isNotEmpty) {
                              showCustomToast(
                                message: validationErrors[0],
                                type: "err",
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DocItemWidget extends StatelessWidget {
  final String text;
  final File? image;
  final Function? onTap;
  final String? url;
  const DocItemWidget({
    super.key,
    required this.text,
    this.image,
    this.onTap,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: context.height * 0.13,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(.2),
            image: image != null
                ? DecorationImage(
                    image: FileImage(image!),
                    fit: BoxFit.cover,
                  )
                : url != null
                    ? DecorationImage(
                        image: NetworkImage(url ?? ""),
                        fit: BoxFit.fill,
                      )
                    : null),
        child: image != null || url != null
            ? const SizedBox()
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.upload, color: context.primaryColor),
                  const SizedBox(height: 15),
                  TextVariation(
                    text: text,
                    size: 12,
                    weight: FontWeight.w500,
                    align: TextAlign.center,
                    color: context.primaryColor,
                  ),
                ],
              ),
      ),
    );
  }
}
