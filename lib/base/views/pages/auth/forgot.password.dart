part of '../pages.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
                text: "Forgot Password, No worries!",
                size: 24,
                weight: FontWeight.w700,
              ),
              const SizedBox(height: 5),
              const TextVariation(
                text:
                    "Enter your email to a recieve an OTP to reset your password",
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
              const SizedBox(height: 10),
              PrimaryButton(text: "Send OTP", onPressed: () {}),
              SizedBox(height: context.height * 0.03),
              TextButtonWidget(
                text: "Login",
                textAlign: TextAlign.center,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
