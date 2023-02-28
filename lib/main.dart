import 'package:employee_app/page/edit_profile.dart';
import 'package:employee_app/page/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'page/home_page.dart';
import 'page/login.dart';
import './constant/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCQfihUk4Fyngu9-DB3O17NloBM8vpIIVE",
        authDomain: "karina-dexa.firebaseapp.com",
        projectId: "karina-dexa",
        storageBucket: "karina-dexa.appspot.com",
        messagingSenderId: "196096721783",
        appId: "1:196096721783:web:97b0a6115650106899d772"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      initialRoute: RoutesName.LOGIN,
      onGenerateRoute: (settings) {
        RouteGenerator.generateRoute(settings, settings.name);
      },
      routes: {
        RoutesName.LOGIN: (context) => const Login(),
        RoutesName.HOME_PAGE: (context) => const HomePage(),
        RoutesName.PROFILE: (context) => const Profile(),
        RoutesName.PROFILE_EDIT: (context) => const EditProfile()
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: const Color(0xffaa2929))),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings, String? name) {
    switch (name) {
      case RoutesName.LOGIN:
        return MaterialPageRoute(
            builder: (context) => const Login(), settings: settings);
      case RoutesName.HOME_PAGE:
        return MaterialPageRoute(
            builder: (context) => const HomePage(), settings: settings);
      case RoutesName.PROFILE:
        return MaterialPageRoute(
            builder: (context) => const Profile(), settings: settings);
      case RoutesName.PROFILE_EDIT:
        return MaterialPageRoute(
            builder: (context) => const EditProfile(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const Login(), settings: settings);
    }
  }
}
