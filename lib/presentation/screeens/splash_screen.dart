import 'package:creative/presentation/screeens/authentication/login_screen.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Call the method to check user sign-in status
//  //   _checkUserSignIn(context);
// navigateToLoginScreen(context);
//     return Scaffold(backgroundColor: black,
//       body: SizedBox(
//         height: double.infinity,
//         width: double.infinity,
//         child: SafeArea(
//           child: Center(
//             child: Lottie.asset('assets/animation/gold.json'),
//           ),
//         ),
//       ),
//     );
//   }

// void _checkUserSignIn(BuildContext context) async {
//   await Future.delayed(const Duration(seconds: 5));
//   // Check if the user is signed in
//   User? user = FirebaseAuth.instance.currentUser;

//   // If user is signed in, navigate to HomePage
//   if (user != null) {
//     // Optionally, you can save the sign-in status in SharedPreferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const Homepage()),
//     );
//   } else {
//     // If user is not signed in, navigate to LoginPage
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }
// }
// }
Future<void> navigateToLoginScreen(BuildContext context) async {
  await Future.delayed(Duration(seconds: 2));
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _textAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    navigateToLoginScreen(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: _logoAnimation,
              child: Lottie.asset(
                'assets/animation/gold.json',
                width: 250,
              ),
            ),
            SlideTransition(
              position: _textAnimation,
              child: Text(
                "Aurify ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 40.sp),
              ),
            ),
            SlideTransition(
              position: _textAnimation,
              child: Text(
                "Gold trding platform",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
