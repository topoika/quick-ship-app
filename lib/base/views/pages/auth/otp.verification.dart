part of "../pages.dart";

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final TextEditingController sms = TextEditingController();
  int countdown = 60;
  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          if (countdown > 0) {
            countdown--;
          } else {
            timer.cancel();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String otp = context.read<OtpCubit>().state.otp ?? "";
    String type = context.read<OtpCubit>().state.type ?? "";

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
                text: "Verify OTP",
                size: 24,
                weight: FontWeight.w700,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextVariation(
                  text:
                      "Enter a 4 digit OTP sent to ${activeUser.value.email ?? "johnme@domain.com"}",
                  size: 12,
                  align: TextAlign.center,
                  weight: FontWeight.w500,
                  opacity: 0.5,
                ),
              ),
              SizedBox(height: context.height * 0.03),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: PinCodeTextField(
                    appContext: context,
                    enablePinAutofill: true,
                    pastedTextStyle: inputTextStyle(context: context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    length: 4,
                    textStyle: inputTextStyle(context: context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    obscureText: false,
                    animationType: AnimationType.scale,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(6),
                        fieldHeight: 60,
                        fieldWidth: 60,
                        borderWidth: .8,
                        activeBorderWidth: .8,
                        errorBorderWidth: .8,
                        errorBorderColor: const Color(0xffD8D6D6),
                        selectedFillColor: const Color(0xffD8D6D6),
                        selectedColor: const Color(0xffD8D6D6),
                        inactiveFillColor: const Color(0xffD8D6D6),
                        activeFillColor: const Color(0xffD8D6D6),
                        selectedBorderWidth: .8),
                    cursorColor: Theme.of(context).primaryColor,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: sms,
                    keyboardType: TextInputType.number,
                    onCompleted: (val) => FocusScope.of(context).unfocus(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Visibility(
                visible: type == "verifying",
                replacement: PrimaryButton(
                  text: "Verify",
                  onPressed: () {
                    if (sms.text == otp) {
                      showCustomToast(message: "Verified", type: "suc");
                      Navigator.pushNamed(context, AppRoutes.resetPassword);
                    } else {
                      showCustomToast(message: "Invalid OTP code", type: "err");
                    }
                  },
                ),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      showCustomToast(message: state.message, type: "err");
                    } else if (state is VerificationSuccess) {
                      showCustomToast(message: "Verified", type: "suc");
                      activeUser.value.verified = true;
                      context.read<OtpCubit>().clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.tabs, (route) => false);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "Verify",
                        loading: state is AuthLoading,
                        onPressed: () {
                          if (sms.text == otp) {
                            context
                                .read<AuthBloc>()
                                .add(VerifyEmailOtp(otp: otp));
                          } else {
                            showCustomToast(
                                message: "Invalid OTP code", type: "err");
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: context.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextVariation(
                    text: "00:${countdown.toString().padLeft(2, '0')}",
                    weight: FontWeight.w600,
                    size: 13,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const TextVariation(
                          text: "Didn't recieve Activation Code? ",
                          weight: FontWeight.w500,
                        ),
                        Visibility(
                          visible: countdown == 0,
                          child: TextButtonWidget(
                            text: "Resend",
                            onPressed: () {
                              setState(() => countdown = 60);
                              startCountdown();
                              if (type == "verifying") {
                                context.read<AuthBloc>().add(RequestEmailOtp());
                              } else {
                                // come on request for reset password code
                              }
                              showCustomToast(message: "Resending OTP code");
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
