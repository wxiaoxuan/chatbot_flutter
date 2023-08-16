import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:chatbot_flutter/screens/login_screen.dart';
import 'package:chatbot_flutter/screens/registration_screen.dart';
import 'package:chatbot_flutter/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String welcomeRouteID = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// with SingleTickerProviderStateMixin : for single animation
// with TickerProviderStateMixin : for multiple animations

// turn this state object, State<WelcomeScreen>, into smth that can act as a ticker by adding with SingleTickerProviderStateMixin
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // Create Custom Flutter Animation w Animation Controller
  late AnimationController controller;
  late Animation curvedAnimation; // for curved animation
  late Animation tweenAnimationLogin; // for tween animation login btn
  late Animation tweenAnimationRegisterBtn; // for tween animation register btn

  @override
  void initState() {
    super.initState();

    // ==================================================================================
    // Linear Animation (small to big 0-100)
    // ==================================================================================
    // vsync: provide ticker provider to create animation controller
    // ticker provider is gg to be the state object aka _WelcomeScreenState
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this, // who is gg to provide the ticker for animation controller
      // upperBound: 100.0,
    );

    // ==================================================================================
    // Curved Animation
    // ==================================================================================
    // curve: have to draw 0 to 1. cannot be above 1 for upperBound
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    // To proceed the animation forward
    controller.forward();

    // To reverse the animation
    // controller.reverse(from: 1.0);

    // To loop the animation (small > big > small > big)
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    //   // status - forward end result: AnimationStatus.complete
    //   // status - reverse end result: AnimationStatus.dismissed
    //   // print(status);
    // });

    // ==================================================================================
    // Tween Animation
    // ==================================================================================
    tweenAnimationLogin =
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.lightBlue)
            .animate(controller);

    tweenAnimationRegisterBtn =
        ColorTween(begin: Colors.lightBlue, end: Colors.blueAccent)
            .animate(controller);

    // Loader - used in Text Ln 14
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
      // print(curvedAnimation.value);
    });

    // Dispose our controller when the WelcomeScreen State is gg to be destroyed to prevent staying in memory (aka hogging resources)
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: tweenAnimation.value,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  // 1. Add hero widget
                  tag: 'logo', // 2. make sure to match the logo in both files
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    // height: curvedAnimation.value * 100,
                  ),
                ),
                // Document this part down for animated_text_kit animation (before & after)
                // NEW
                // TypewriterAnimatedTextKit(
                //   text: [
                //     'Flash Chat',
                //   ],
                //   textStyle: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //     color: Colors.black87,
                //   ),
                // ),
                // OLD
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Login',
              color: tweenAnimationLogin.value,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.loginRouteID);
              },
            ),
            RoundedButton(
              title: 'Register',
              color: tweenAnimationRegisterBtn.value,
              onPressed: () {
                Navigator.pushNamed(
                    context, RegistrationScreen.registerRouteID);
              },
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Loading: ${controller.value.toInt()}%',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// References:
// Normal Animation
// CurvedAnimation class: https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html
// Curves class: https://api.flutter.dev/flutter/animation/Curves-class.html
// Tween Animation

// Pre-packaged Animations
// - Flutter Sequence Animation: https://pub.dev/packages/flutter_sequence_animation
// - Rubber: https://pub.dev/packages/rubber
// - Sprung: https://pub.dev/packages/sprung
// - Animated Text Kit: https://pub.dev/packages/animated_text_kit
