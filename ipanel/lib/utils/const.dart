
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void closeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

Widget closeKeyboardWidget(BuildContext context, {required Widget child}) {
  return GestureDetector(
    onTap: () => closeKeyboard(context),
    child: child,
  );
}

// 画面の向きを縦向きに固定
void setPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
// 画面の向きを横向きに固定
void setLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

class MyColors {
  static Color primary = LightGreenColors.primary;
  static Color primaryDark = LightGreenColors.primary;
  static Color secondary = LightGreenColors.secondary;
  static Color accent = LightGreenColors.accent;
  static Color background = LightGreenColors.background;
}

class LightGreenColors {
  static Color primary = const Color(0xff4CAF50);
  static Color secondary = const Color(0xffE8F5E9);
  static Color accent = const Color(0xffFF5722);
  static Color background = const Color(0xffFFFFFF);
  static Color surface = const Color(0xffFAFAFA);
  static Color text = const Color(0xff212121);

  static List<Color> defaultGradients = [
    const Color(0xFF4CAF50),
    const Color(0xFFE8F5E9),
  ];
}

final List<String> myGoogleFonts = [
  // "Abril Fatface",
  // "Aclonica",
  // "Alegreya Sans",
  // "Architects Daughter",
  // "Archivo",
  // "Archivo Narrow",
  // "Bebas Neue",
  // "Bitter",
  // "Bree Serif",
  // "Bungee",
  // "Cabin",
  // "Cairo",
  // "Coda",
  // "Comfortaa",
  // "Comic Neue",
  // "Cousine",
  // "Croissant One",
  // "Faster One",
  // "Forum",
  // "Great Vibes",
  // "Heebo",
  // "Inconsolata",
  "Inter",
  // "Josefin Slab",
  "Lato",
  // "Libre Baskerville",
  // "Lobster",
  "Lora",
  "Merriweather",
  "Montserrat",
  // "Mukta",
  "Nunito",
  // "Offside",
  "Open Sans",
  "Oswald",
  // "Overlock",
  // "Pacifico",
  // "Playfair Display",
  "Poppins",
  "Raleway",
  "Roboto",
  "Roboto Mono",
  "Source Sans Pro",
  // "Space Mono",
  // "Spicy Rice",
  // "Squada One",
  // "Sue Ellen Francisco",
  // "Trade Winds",
  "Ubuntu",
  // "Varela",
  // "Vollkorn",
  // "Work Sans",
  // "Zilla Slab",
];
