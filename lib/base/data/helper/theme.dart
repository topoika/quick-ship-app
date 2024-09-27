part of "../data.dart";

const ColorScheme colorScheme = ColorScheme(
  primary: Color(0xFF0044B1),
  secondary: Color(0xFF0044B1),
  surface: Color(0xFFFFFFFF),
  error: Color(0xFFB00020),
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);
ThemeData lightTheme = ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  primaryColor: AppContants.primaryColor,
  fontFamily: "Poppins",
  scaffoldBackgroundColor: colorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.surface,
    elevation: 0,
    centerTitle: true,
  ),
);

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Color get primaryColor => theme.primaryColor;

  Color get backgroundColor => theme.colorScheme.surface;
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  Color get indicatorColor => theme.indicatorColor;
  Color get canvasColor => theme.canvasColor;
  Color get shadowColor => theme.shadowColor;
  Color get dividerColor => theme.dividerColor;
  Color get highlightColor => theme.highlightColor;
  Color get splashColor => theme.splashColor;

  Color get unselectedWidgetColor => theme.unselectedWidgetColor;
  Color get disabledColor => theme.disabledColor;

  Color get focusColor => theme.focusColor;
  Color get hoverColor => theme.hoverColor;

  Color get cardColor => theme.cardColor;
  Color get dialogBackgroundColor => theme.dialogBackgroundColor;

  double get horPad => AppContants.horPad;
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
}

class SytemStyle {
  static init() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
