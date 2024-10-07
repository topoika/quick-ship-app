// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

void showCustomDialog(
    {required BuildContext context, required DialogData data}) {
  showDialog(
    context: context,
    builder: (context) => CustomDialog(
      description: data.description ?? "",
      title: data.title!,
      noText: data.noText!,
      yesText: data.yesText!,
      yesOnPressed: () => data.yesOnPressed(),
      noOnPressed: () => data.noOnPressed!(),
      type: data.type!,
    ),
  );
}

void showMpesaNumberDialog(
    {required BuildContext context, required Function(String) onsubmit}) {
  showDialog(
    context: context,
    builder: (context) => MpesaDialog(onsubmit: onsubmit),
  );
}

class DialogData {
  String? title;
  String? description;
  String? yesText;
  String? noText;
  Function yesOnPressed;
  Function? noOnPressed;
  String? type;
  DialogData(
      {this.title,
      this.description,
      this.yesText,
      this.noText,
      required this.yesOnPressed,
      this.noOnPressed,
      this.type});
}

class CustomDialog extends StatelessWidget {
  final String type;
  final String title;
  final String description;
  final String noText;
  final String yesText;
  final Function? noOnPressed;
  final Function yesOnPressed;
  const CustomDialog({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.noText,
    required this.yesText,
    this.noOnPressed,
    required this.yesOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              type == "warning"
                  ? AppStrings.warningImage
                  : AppStrings.infoImage,
              height: 70,
              width: 70,
              color: type == "warning" ? Colors.red : context.primaryColor,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            TextVariation(
                text: title,
                size: 18,
                weight: FontWeight.w500,
                align: TextAlign.center),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
              child: TextVariation(
                text: description,
                size: 14,
                weight: FontWeight.w400,
                align: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => (noOnPressed != null
                        ? noOnPressed!()
                        : Navigator.pop(context)),
                    child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            width: 1,
                            color: type == "warning"
                                ? Colors.red
                                : context.primaryColor),
                      ),
                      child: Text(
                        noText,
                        textAlign: TextAlign.center,
                        textScaler: TextScaler.noScaling,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: type == "warning"
                              ? Colors.red
                              : context.primaryColor,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => yesOnPressed(),
                    child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: type == "warning"
                            ? Colors.red
                            : context.primaryColor,
                      ),
                      child: Text(
                        yesText,
                        textAlign: TextAlign.center,
                        textScaler: TextScaler.noScaling,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

GlobalKey<FormState> mpesaFormKey = GlobalKey<FormState>();

class MpesaDialog extends StatelessWidget {
  final Function(String) onsubmit;
  const MpesaDialog({
    super.key,
    required this.onsubmit,
  });

  @override
  Widget build(BuildContext context) {
    String number = "";
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          color: Colors.white,
        ),
        child: Form(
          key: mpesaFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const TextVariation(
                text: "Payment MPesa Number",
                weight: FontWeight.w600,
                size: 15,
              ),
              const TextVariation(
                text: "Enter mpesa number to recieve prompt for this payment",
                weight: FontWeight.w500,
                size: 12,
                opacity: .7,
              ),
              const SizedBox(height: 10),
              NewItemInputField(
                hint: "Mpesa Number",
                type: "mpesa_number",
                init: activeUser.value.phone?.replaceAll("+254", "0"),
                onSaved: (value) => number = value!,
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: PrimaryButtonUnfilled(
                      text: "Cancel",
                      color: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: PrimaryButton(
                      text: "Submit",
                      onPressed: () {
                        validationErrors.clear();
                        if (mpesaFormKey.currentState!.validate()) {
                          mpesaFormKey.currentState!.save();
                          onsubmit(number.replaceAll(" ", ""));
                        } else {
                          if (validationErrors.isNotEmpty) {
                            showCustomToast(
                                message: validationErrors[0], type: "err");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
