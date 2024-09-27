// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class TextVariation extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final FontWeight? weight;
  final double? opacity;
  final double? size;
  final Color? color;
  const TextVariation({
    super.key,
    required this.text,
    this.align,
    this.weight,
    this.opacity,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: TextScaler.noScaling,
      textAlign: align ?? TextAlign.left,
      style: TextStyle(
        fontSize: size ?? 13,
        height: 1.5,
        color: (color ?? Colors.black).withOpacity(opacity ?? 1),
        fontWeight: weight ?? FontWeight.w400,
      ),
    );
  }
}
