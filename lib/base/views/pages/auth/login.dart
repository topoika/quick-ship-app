part of "../pages.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 10),
          child: Form(
            key: loginFormKey,
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
                  text: "Welcome Back",
                  size: 24,
                  weight: FontWeight.w700,
                ),
                const SizedBox(height: 5),
                const TextVariation(
                  text: "Login to your account",
                  size: 14,
                  weight: FontWeight.w500,
                  opacity: 0.5,
                ),
                SizedBox(height: context.height * 0.02),
                InputFieldWidget(
                  hint: "Email",
                  type: "email",
                  title: "Email",
                  required: true,
                  onSaved: (val) => activeUser.value.email = val,
                ),
                InputFieldWidget(
                  title: "Password",
                  hint: "Password",
                  type: "password",
                  required: true,
                  onSaved: (val) => activeUser.value.password = val,
                ),
                const SizedBox(height: 10),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      showCustomToast(message: state.message, type: "err");
                    } else if (state is LoginSuccess) {
                      showCustomToast(
                          message: "User login successfully", type: 'suc');
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.tabs, (route) => false);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "Login",
                        loading: state is AuthLoading,
                        onPressed: () {
                          if (loginFormKey.currentState!.validate()) {
                            loginFormKey.currentState!.save();
                            context
                                .read<AuthBloc>()
                                .add(AuthLogin(user: activeUser.value));
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
                TextButtonWidget(
                  text: "Forgot Password?",
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                ),
                SizedBox(height: context.height * 0.05),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextVariation(
                        text: "OR",
                        weight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    socialIcons(
                      imageUrl: AppStrings.google,
                      onTap: () =>
                          showCustomToast(message: "Coming soon...👩‍💻"),
                    ),
                    socialIcons(
                      imageUrl: AppStrings.facebook,
                      onTap: () =>
                          showCustomToast(message: "Coming soon...👩‍💻"),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const TextVariation(
                      text: "Don't have an account? ",
                      weight: FontWeight.w500,
                    ),
                    TextButtonWidget(
                      text: "Register",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
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

  Widget socialIcons({required String imageUrl, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      splashColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: QImage(
          imageUrl: imageUrl,
          height: 30,
        ),
      ),
    );
  }
}
