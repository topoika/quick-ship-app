// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class DropDownInputWidget extends StatelessWidget {
  final String? init;
  final String? title;
  final List<dynamic> items;
  final Function onSaved;
  final bool? required;
  const DropDownInputWidget({
    super.key,
    this.init,
    this.title,
    required this.items,
    required this.onSaved,
    this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: DropdownButtonFormField(
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(AppConstants.radius),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: const TextStyle(fontSize: 0),
              ),
              onSaved: (val) => onSaved(val),
              value: init ?? items[0],
              onChanged: (newValue) {},
              items: items.map<DropdownMenuItem>((m) {
                return DropdownMenuItem(
                  value: m,
                  child: Text(
                    m,
                    textScaler: TextScaler.noScaling,
                    style: inputTextStyle(context: context),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
