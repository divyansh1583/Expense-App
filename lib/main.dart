import 'package:expense_app/screen/home_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.redAccent);
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((value) {
  runApp(
    const MyApp(),
  );
  // s
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*
      theme: ThemeData(useMaterial3: true), 
      this changes all themes according material 3 and all local themeing of widgets is ignored 
      */

      //using .copyWith() lets us keep local styling of widget and
      // we can change themeing indivisually of every components we want
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        // scaffoldBackgroundColor: kColorScheme.background,
        appBarTheme: AppBarTheme(
          // backgroundColor: kColorScheme.onSecondaryContainer,
          backgroundColor: Colors.redAccent.shade700,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme(
          color: Colors.redAccent.shade200.withRed(255),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
            foregroundColor: kColorScheme.onSecondaryContainer,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 16,
            color: kColorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        // inputDecorationTheme: const InputDecorationTheme(
        //   labelStyle: TextStyle(color: Colors.white),
        // ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: kColorScheme.background,
        appBarTheme: AppBarTheme(
          // backgroundColor: kColorScheme.onSecondaryContainer,
          backgroundColor: Colors.redAccent.shade700,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme(
          color: Colors.redAccent.shade200.withRed(255),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
            foregroundColor: kColorScheme.onSecondaryContainer,
          ),
        ),
        // textTheme: TextTheme(
        //   titleLarge: TextStyle(
        //     fontSize: 16,
        //     color: kColorScheme.onPrimaryContainer,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   // titleSmall: TextStyle(color: Colors.black),
        // ),
      ),
      home: const HomeScreen(),
    );
  }
}
