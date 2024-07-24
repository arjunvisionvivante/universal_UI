// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/services/AuthServices.dart';
import 'package:universal_f_widgets/ui/secreens/ChangePasswordSecreen.dart';
import 'package:universal_f_widgets/ui/secreens/ForgotPasswordScreen.dart';
import 'package:universal_f_widgets/ui/secreens/HomeScreen.dart';
import 'package:universal_f_widgets/ui/secreens/LoginScreen.dart';
import 'package:universal_f_widgets/ui/secreens/ProfileScreen.dart';
import 'package:universal_f_widgets/ui/secreens/SignupScreen.dart';
import 'package:universal_f_widgets/viewmodels/ProfileViewModel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF8E24AA),
        // Custom primary color
        canvasColor: Color(0xFFD1C4E9),
        // Custom accent color
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFD1C4E9), // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Button shape
          ),
          textTheme: ButtonTextTheme.primary, // Text color for buttons
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF8E24AA),
          ),
        ),
      ),
      home: LoginScreen(),
      // Start with the login screen
      // ... other routes
      routes: {
        '/signup': (context) => SignupScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/profile': (context) => ProfilePage(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/change-password':(context)=>ChangePaswordPage(),
      },
    );
  }
}
