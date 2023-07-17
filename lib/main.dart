import 'package:flutter/material.dart';
import 'package:pract4/widgets/expenses.dart';

var kcolorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181)
  );
void main() {
  runApp(
     MaterialApp(
      theme: ThemeData().copyWith(useMaterial3: true,
      colorScheme: kcolorScheme,
      appBarTheme: const AppBarTheme().copyWith(
         backgroundColor: kcolorScheme.onPrimaryContainer,
        foregroundColor: kcolorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: kcolorScheme.secondaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: kcolorScheme.primaryContainer,
      )),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kcolorScheme.onSecondaryContainer,
          fontSize: 16,
        )
      )
      ),
      home: const Expenses(),
    )
  );
}
