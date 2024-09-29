part of "../data.dart";

String formatCurrency({dynamic value}) {
  final formatter = NumberFormat.currency(
    locale: 'en',
    symbol: 'KSH',
    decimalDigits: 0,
  );
  return formatter.format(double.parse(value.toString()));
}
