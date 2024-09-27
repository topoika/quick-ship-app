part of "../components.dart";

class InputFieldWidget extends StatelessWidget {
  final String? title;
  final bool? required;
  final String hint;
  final String type;
  final Function(String?)? onSaved;
  const InputFieldWidget({
    super.key,
    this.title,
    this.onSaved,
    this.required = false,
    required this.hint,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    bool password = ["password", "confirm_password"].contains(type);
    bool visible = context.watch<PasswordCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Visibility(
            visible: title != null,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: <Widget>[
                  TextVariation(
                    text: title ?? "",
                    weight: FontWeight.w500,
                  ),
                  Visibility(
                    visible: required!,
                    child: const TextVariation(
                      text: "*",
                      color: Colors.redAccent,
                      opacity: .7,
                    ),
                  )
                ],
              ),
            ),
          ),
          MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: TextFormField(
              inputFormatters: inputFormatters(type),
              validator: (val) => validator(val, type),
              style: inputTextStyle(context: context),
              keyboardType: getTextInputType(type),
              onSaved: onSaved,
              obscureText: password ? visible : true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: hint,
                hintStyle: hintTextStyle(context: context),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                suffixIcon: password
                    ? IconButton(
                        icon: !visible
                            ? const Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black87,
                              ),
                        onPressed: () {
                          context.read<PasswordCubit>().toggleVisibility();
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(AppConstants.radius),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// hint text style
TextStyle hintTextStyle({required BuildContext context}) {
  return const TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );
}

// input text style
TextStyle inputTextStyle({required BuildContext context}) {
  return const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );
}
