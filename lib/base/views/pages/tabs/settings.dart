part of "../pages.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextVariation(
          text: "Settings",
          size: 18,
          weight: FontWeight.w600,
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: context.horPad),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
              child: const QImage(
                imageUrl: AppStrings.editIcon,
                height: 20,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 5),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 47,
                    width: 47,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: activeUser.value.image != null
                          ? DecorationImage(
                              image: NetworkImage(activeUser.value.image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: activeUser.value.image != null
                        ? const SizedBox()
                        : const Icon(
                            Icons.person,
                            size: 30,
                          ),
                  ),
                  SizedBox(width: context.width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextVariation(
                            text: activeUser.value.name ?? "",
                            size: 16,
                            weight: FontWeight.w600,
                          ),
                          Visibility(
                            visible:
                                (activeUser.value.verificationBack != null ||
                                        activeUser.value.verificationFront !=
                                            null) &&
                                    activeUser.value.verified == false,
                            child: Container(
                              margin: const EdgeInsets.only(left: 5, top: 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const TextVariation(
                                text: "Pending",
                                color: Colors.white,
                                size: 7,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: activeUser.value.verified ?? false,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2, left: 3),
                              child: Icon(
                                Icons.verified,
                                color: Colors.blue[700],
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      TextVariation(
                        text: activeUser.value.email ?? "",
                        opacity: 0.6,
                        weight: FontWeight.w500,
                        size: 12,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: context.height * 0.02),
              SettingsItem(
                title: "My Packages",
                image: AppStrings.boxIcon,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.myPackages);
                },
              ),
              SettingsItem(
                title: "Order History",
                image: AppStrings.receiptIcon,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.myOrders);
                },
              ),
              SettingsItem(
                title: "FAQs",
                image: AppStrings.faqIcon,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.faqs);
                },
              ),
              SettingsItem(
                title: "Help & Support",
                image: AppStrings.helpIcon,
                onTap: () {
                  showCustomToast(message: "Coming soon");
                },
              ),
              SettingsItem(
                title: "About - Legal & Policy",
                image: AppStrings.infoIcon,
                onTap: () {
                  showCustomToast(message: "Coming soon");
                  print("Time ${DateTime.now()}");
                },
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    showCustomToast(message: state.message, type: "err");
                  } else if (state is LogoutSuccess) {
                    showCustomToast(
                        message: "Logged out successfully", type: "suc");
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          data: DialogData(
                            title: "Confirm Logout",
                            description:
                                "Are you sure you want to log out? You’ll need to log in again to access your account.",
                            noText: "Cancel",
                            yesText: "Log Out",
                            yesOnPressed: () {
                              Navigator.pop(context);
                              context.read<AuthBloc>().add(Logout());
                            },
                            noOnPressed: () {
                              Navigator.pop(context);
                            },
                            type: "warning",
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: context.primaryColor.withOpacity(.07),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.logout_outlined,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(width: context.width * 0.03),
                            const TextVariation(
                              text: "Logout",
                              size: 16,
                              weight: FontWeight.w600,
                            ),
                            const Spacer(),
                            Visibility(
                              visible: true,
                              replacement: CupertinoActivityIndicator(
                                color: context.primaryColor,
                                radius: 10,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    showCustomToast(message: state.message, type: "err");
                  } else if (state is DeleteAccountSuccess) {
                    showCustomToast(
                        message: "Account deleted successfully", type: "suc");
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return SettingsItem(
                      title: "Delete Account",
                      loading: state is AuthLoading,
                      image: AppStrings.deleteIcon,
                      color: Colors.red,
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          data: DialogData(
                            title: "Confirm Deletion",
                            description:
                                "Are you sure you want to delete your account? This action cannot be undone.",
                            noText: "Cancel",
                            yesText: "Delete",
                            yesOnPressed: () {
                              Navigator.pop(context);
                              context.read<AuthBloc>().add(DeleteUserAccount());
                            },
                            noOnPressed: () {
                              Navigator.pop(context);
                            },
                            type: "warning",
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String image;
  final Function()? onTap;
  final bool? loading;
  final Color? color;
  const SettingsItem({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
    this.loading,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (loading == true) {
          return;
        } else {
          onTap!();
        }
      },
      splashColor: context.primaryColor.withOpacity(.01),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (color ?? context.primaryColor).withOpacity(.07),
                shape: BoxShape.circle,
              ),
              child: QImage(
                imageUrl: image,
                height: 25,
                color: color ?? context.primaryColor,
              ),
            ),
            SizedBox(width: context.width * 0.03),
            TextVariation(
              text: title,
              size: 16,
              weight: FontWeight.w600,
            ),
            const Spacer(),
            Visibility(
              visible: loading != true,
              replacement: CupertinoActivityIndicator(
                color: context.primaryColor,
                radius: 10,
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
