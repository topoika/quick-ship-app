part of "../pages.dart";

GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    String otp = context.read<OtpCubit>().state.otp ?? "";

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 10),
          child: Form(
            key: passwordFormKey,
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
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      showCustomToast(message: state.message, type: "err");
                    } else if (state is PasswordResetSuccess) {
                      showCustomToast(
                          message: "Password reset successfully", type: 'suc');
                      context.read<OtpCubit>().clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.login, (route) => false);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "Submit",
                        onPressed: () {
                          if (passwordFormKey.currentState!.validate()) {
                            passwordFormKey.currentState!.save();
                            context.read<AuthBloc>().add(ResetPasswordEvent(
                                otp: otp,
                                password: activeUser.value.password!));
                          } else {
                            if (validationErrors.isNotEmpty) {
                              showCustomToast(
                                  message: validationErrors[0], type: "err");
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: context.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
