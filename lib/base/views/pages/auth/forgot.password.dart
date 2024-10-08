part of '../pages.dart';
GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 10),
          child: Form(
            key: forgotPasswordFormKey,
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
                  text: "Forgot Password, No worries!",
                  size: 24,
                  weight: FontWeight.w700,
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextVariation(
                    text:
                        "Enter your email to a recieve an OTP to reset your password",
                    size: 12,
                    align: TextAlign.center,
                    weight: FontWeight.w500,
                    opacity: 0.5,
                  ),
                ),
                SizedBox(height: context.height * 0.02),
                InputFieldWidget(
                  hint: "Email",
                  type: "email",
                  title: "Email",
                  required: true,
                  onSaved: (val) => activeUser.value.email = val,
                ),
                const SizedBox(height: 15),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      showCustomToast(message: state.message, type: "err");
                    } else if (state is PasswordOTPRequestLoaded) {
                      showCustomToast(
                          message: "Reset OTP send succesfully", type: 'suc');
                      context
                          .read<OtpCubit>()
                          .setOtpState(state.otp, "resetting");
                      Navigator.pushNamed(context, AppRoutes.otpVerification);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "Send OTP",
                        loading: state is AuthLoading,
                        onPressed: () {
                          validationErrors.clear();
                          if (forgotPasswordFormKey.currentState!.validate()) {
                            forgotPasswordFormKey.currentState!.save();
                            context.read<AuthBloc>().add(RequestResetPassword(
                                email: activeUser.value.email!));
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const TextVariation(
                      text: "Back to ",
                      weight: FontWeight.w500,
                    ),
                    TextButtonWidget(
                      text: "Login",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
