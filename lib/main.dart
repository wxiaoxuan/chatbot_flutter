import 'package:flutter/material.dart';
import 'package:chatbot_flutter/screens/welcome_screen.dart';
import 'package:chatbot_flutter/screens/login_screen.dart';
import 'package:chatbot_flutter/screens/registration_screen.dart';
import 'package:chatbot_flutter/screens/chat_screen.dart';

import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyLarge: TextStyle(color: Colors.black54),
      //   ),
      // ),
      // home: WelcomeScreen(),
      initialRoute: WelcomeScreen.welcomeRouteID,
      routes: {
        WelcomeScreen.welcomeRouteID: (context) => WelcomeScreen(),
        LoginScreen.loginRouteID: (context) => LoginScreen(),
        RegistrationScreen.registerRouteID: (context) => RegistrationScreen(),
        ChatScreen.chatRouteID: (context) => ChatScreen(),
      },
    );
  }
}
