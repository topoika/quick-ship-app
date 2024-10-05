part of "../pages.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 10),
          child: Form(
            key: registerFormKey,
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
                  text: "Let's Create your Account",
                  size: 24,
                  weight: FontWeight.w700,
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextVariation(
                    text:
                        "Enter your details to get things started, Info should be accurate for verification purposes",
                    align: TextAlign.center,
                    size: 12,
                    weight: FontWeight.w500,
                    opacity: 0.5,
                  ),
                ),
                SizedBox(height: context.height * 0.02),
                InputFieldWidget(
                  title: "Full Name",
                  hint: "Full Name",
                  type: "name",
                  required: true,
                  onSaved: (val) => activeUser.value.name = val,
                ),
                InputFieldWidget(
                  hint: "Email",
                  type: "email",
                  title: "Email",
                  required: true,
                  onSaved: (val) => activeUser.value.email = val,
                ),
                PhoneInputField(
                  hint: "Phone Number",
                  disabled: false,
                  onSaved: (val) => activeUser.value.phone = val,
                ),
                InputFieldWidget(
                  title: "ID Number",
                  hint: "ID/Passport Number",
                  type: "id_number",
                  required: true,
                  onSaved: (val) => activeUser.value.idNumber = val,
                ),
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
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const TextVariation(
                        text: "By signing up, I am agreeing to the "),
                    TextButtonWidget(
                      text: "Terms & Conditions",
                      onPressed: () =>
                          showCustomToast(message: "Coming soon...👩‍💻"),
                    ),
                    const TextVariation(text: " and "),
                    TextButtonWidget(
                      text: "Privacy Policy",
                      onPressed: () =>
                          showCustomToast(message: "Coming soon...👩‍💻"),
                    ),
                    const TextVariation(text: " of this ${AppStrings.appName}"),
                  ],
                ),
                const SizedBox(height: 15),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      showCustomToast(message: state.message, type: "err");
                    } else if (state is EmailVerificationSent) {
                      showCustomToast(
                          message: "User registered successfully", type: 'suc');
                      context
                          .read<OtpCubit>()
                          .setOtpState(state.otp, "verifying");
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.otpVerification);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "Register",
                        loading: state is AuthLoading,
                        onPressed: () {
                          if (registerFormKey.currentState!.validate()) {
                            registerFormKey.currentState!.save();
                            context
                                .read<AuthBloc>()
                                .add(AuthRegister(user: activeUser.value));
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
                      text: "Alread have an Account? ",
                      weight: FontWeight.w500,
                    ),
                    TextButtonWidget(
                      text: "Login",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                    ),
                  ],
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
