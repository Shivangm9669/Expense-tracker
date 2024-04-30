import 'package:expense_tracker/screen/mainscreenpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme kcolorschema =
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 146, 199, 212));

    final ColorScheme kDarkSchema =
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125));
    return MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          colorScheme: kDarkSchema,
          cardTheme: const CardTheme().copyWith(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              color: kDarkSchema.secondaryContainer),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkSchema.primaryContainer)),
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: Theme.of(context).textTheme.titleMedium),
          textTheme: const TextTheme().copyWith(
              titleMedium: TextStyle(color: kDarkSchema.primary, fontSize: 14),
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDarkSchema.primary,
                  fontSize: 16)),
        ),
        theme: ThemeData().copyWith(
            colorScheme: kcolorschema,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kcolorschema.onPrimaryContainer,
                foregroundColor: kcolorschema.primaryContainer),
            cardTheme: const CardTheme().copyWith(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                color: kcolorschema.secondaryContainer),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kcolorschema.primaryContainer)),
            textTheme: const TextTheme().copyWith(
                titleMedium:
                    TextStyle(color: kcolorschema.primary, fontSize: 14),
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kcolorschema.onSecondaryContainer,
                    fontSize: 16)),
            inputDecorationTheme: InputDecorationTheme(
                hintStyle: Theme.of(context).textTheme.titleMedium)),
        home: const ExpenseTrackerMainPage());
  }
}
