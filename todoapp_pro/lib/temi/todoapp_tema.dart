import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappTema {
  static final font = GoogleFonts.bitcountSingleInk(
    fontWeight: FontWeight.bold
  );

  static final tema = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

    // sfondo di tutte le schermate
    scaffoldBackgroundColor: TodoappColori.giallo,

    // tema per le appBar
    appBarTheme: const AppBarTheme(
      backgroundColor: TodoappColori.giallo,
      foregroundColor: TodoappColori.nero,
    ),

    // tema per i testi
    textTheme: TextTheme(
      bodyLarge: font.copyWith(
        color: TodoappColori.nero,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),

      bodyMedium: font.copyWith(
        color: TodoappColori.nero,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),

      bodySmall: font.copyWith(
        color: TodoappColori.grigio,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    useMaterial3: true,
  );
}
