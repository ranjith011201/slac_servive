import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:slac_serve/providers/posts.dart';
import 'screens/registration.dart';
import 'package:provider/provider.dart';
import 'providers/user.dart';
import 'screens/splash.dart';
import 'screens/homeFeed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: PostsProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Registration();
      case Status.Authenticated:
        return HomeFeed();
      default:
        return Registration();
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:slac_serve/screens/homeFeed.dart';
// // import 'package:slac_serve/screens/loginforngo.dart';
// import 'package:slac_serve/screens/registration.dart';
// import 'package:slac_serve/services/user.dart';
// import 'services/user.dart';
// import 'providers/user.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(value: UserProvider()),
//         Provider<AuthenticationService>(
//           create: (_) => AuthenticationService(FirebaseAuth.instance),
//         ),
//         StreamProvider(
//           create: (context) =>
//               context.read<AuthenticationService>().authStateChanges,
//         )
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: AuthenticationWrapper(),
//       ),
//     );
//   }
// }

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User>();

//     if (firebaseUser != null) {
//       return HomeFeed();
//     }
//     return Registration();
//   }
// }
