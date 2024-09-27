part of "../components.dart";

class PrimaryButton extends StatelessWidget {
  final String text;
  final String? icon;
  final bool loading;
  final bool disabled;
  final Function onPressed;
  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    this.loading = false,
    this.disabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled && !loading) onPressed();
      },
      child: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(disabled ? 0.7 : 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: loading
            ? const Padding(
                padding: EdgeInsets.all(7),
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 13,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextVariation(
                  text: text,
                  color: Colors.white,
                  size: 14,
                  weight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String text;
  final bool underlined;
  final Function onPressed;
  final bool? loading;
  final TextAlign? textAlign;
  final FontWeight fontWeight;

  const TextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.underlined = false,
    this.loading,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      splashColor: Colors.transparent,
      child: Stack(
        children: [
          Text(
            text,
            textScaler: TextScaler.noScaling,
            textAlign: textAlign,
            style: TextStyle(
              color: context.primaryColor,
              fontWeight: fontWeight,
              fontSize: 12.5,
            ),
          ),
          if (underlined)
            Positioned(
              bottom: -0.3,
              left: 0,
              right: 0,
              child: Container(
                height: 1.2,
                color: context.primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
