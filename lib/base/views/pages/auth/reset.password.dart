part of "../pages.dart";

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: context.height * 0.1),
              Center(
                child: QImage(
                  imageUrl: AppStrings.logoText,
                  width: context.width * 0.6,
                ),
              ),
              SizedBox(height: context.height * 0.05),
              const TextVariation(
                text: "Reset Password",
                size: 24,
                weight: FontWeight.w700,
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextVariation(
                  text:
                      "Enter your new password to reset your account password",
                  size: 12,
                  align: TextAlign.center,
                  weight: FontWeight.w500,
                  opacity: 0.5,
                ),
              ),
              SizedBox(height: context.height * 0.02),
              InputFieldWidget(
                title: "Password",
                hint: "Password",
                type: "password",
                required: true,
                onSaved: (val) => activeUser.value.password = val,
              ),
              InputFieldWidget(
                title: "Confirm Password",
                hint: "Confirm Password",
                type: "confirm_password",
                required: true,
                onSaved: (val) => activeUser.value.password = val,
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                text: "Submit",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),
              SizedBox(height: context.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
