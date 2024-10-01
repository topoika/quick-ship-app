// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class InputFieldWidget extends StatelessWidget {
  final String? title;
  final bool? required;
  final String hint;
  final String type;
  final Function(String?)? onSaved;
  final String? init;
  const InputFieldWidget({
    super.key,
    this.title,
    this.onSaved,
    this.init,
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
              obscureText: password ? visible : false,
              initialValue: init ?? "",
              textCapitalization: getTextCapitalization(type),
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
                  borderRadius: BorderRadius.circular(5),
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

class NewItemInputField extends StatelessWidget {
  final String hint;
  final String type;
  final String? init;
  final Function(String?) onSaved;
  const NewItemInputField({
    super.key,
    required this.hint,
    required this.type,
    this.init,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: TextFormField(
              inputFormatters: inputFormatters(type),
              validator: (val) => validator(val, type),
              style: inputTextStyle(context: context),
              keyboardType: getTextInputType(type),
              onSaved: onSaved,
              initialValue: init ?? "",
              maxLines: type == "description" ? 5 : 1,
              minLines: 1,
              textCapitalization: getTextCapitalization(type),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: hint,
                hintStyle: hintTextStyle(context: context),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
                  borderRadius: BorderRadius.circular(5),
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

class SelectInputField extends StatelessWidget {
  final String hint;
  final String? value;
  final bool? hasValue;
  final Function? onTap;
  const SelectInputField({
    super.key,
    this.value,
    this.onTap,
    required this.hint,
    this.hasValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!();
      },
      splashColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: TextVariation(
          text: hasValue! ? (value ?? "") : hint,
          size: 13,
          opacity: hasValue! ? 1 : .7,
          weight: hasValue! ? FontWeight.w500 : FontWeight.w400,
        ),
      ),
    );
  }
}
