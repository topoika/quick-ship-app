part of "../components.dart";

class PhoneInputField extends StatefulWidget {
  final String hint;
  final bool disabled;
  final Function(String) onSaved;
  final Function(String)? onChanged;
  const PhoneInputField({
    super.key,
    required this.hint,
    required this.disabled,
    required this.onSaved,
    this.onChanged,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  CountryCode countryCode = CountryCode.fromCountryCode("KE");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              children: <Widget>[
                TextVariation(
                  text: "Phone",
                  weight: FontWeight.w500,
                ),
                TextVariation(
                  text: "*",
                  color: Colors.redAccent,
                  opacity: .7,
                ),
              ],
            ),
          ),
          MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: validationErrors.any((i) => i.contains("Phone"))
                      ? Colors.redAccent
                      : Colors.grey[300]!,
                ),
              ),
              child: Row(
                children: <Widget>[
                  CountryCodePicker(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    initialSelection: 'KE',
                    showCountryOnly: true,
                    alignLeft: false,
                    countryFilter: const ['KE'],
                    enabled: !widget.disabled,
                    onInit: (value) {},
                    onChanged: (value) {
                      countryCode = value;
                      setState(() {});
                    },
                    showFlagDialog: true,
                    showDropDownButton: false,
                    textStyle: inputTextStyle(context: context),
                    comparator: (a, b) => b.name!.compareTo(a.name ?? ""),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 1,
                    height: 50,
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: TextFormField(
                      onSaved: (val) => widget.onSaved(getPhoneNumber(
                          val!.replaceAll(" ", "").trim(), countryCode)),
                      inputFormatters: inputFormatters("phone"),
                      enabled: !widget.disabled,
                      validator: (value) =>
                          validator(value?.replaceAll(" ", "").trim(), "phone"),
                      keyboardType: TextInputType.phone,
                      style: inputTextStyle(context: context),
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        filled: true,
                        fillColor: Colors.grey[200],
                        errorStyle: const TextStyle(fontSize: 0),
                        hintStyle: hintTextStyle(context: context),
                        border: InputBorder.none,
                        counterStyle: const TextStyle(
                            color: Colors.transparent, fontSize: 0),
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getPhoneNumber(String phoneNumber, CountryCode countryCode) {
  if (phoneNumber.startsWith("0")) {
    phoneNumber = phoneNumber.substring(1);
  }
  return countryCode.dialCode! + phoneNumber;
}
