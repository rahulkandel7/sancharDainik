import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/about_screen.dart';
import '../screens/bookmark_screen.dart';
import '../screens/drawerZoom.dart';
import 'screens/subscribe.dart';
import '../screens/news_show.dart';
import '../screens/onBoarding_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'id',
  'title',
  showBadge: true,
  importance: Importance.high,
  playSound: true,
  enableVibration: true,
  enableLights: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sanchar Dainik',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: TextTheme(
          bodyText1: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          headline1: TextStyle(
            color: const Color.fromRGBO(34, 45, 102, 1),
            fontSize: Platform.isAndroid ? 26 : 20,
            fontWeight: FontWeight.w700,
          ),
          headline2: const TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w300,
          ),
          headline4: const TextStyle(
            color: Color.fromRGBO(34, 45, 102, 1),
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          headline5: const TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        shadowColor: Colors.grey.shade200,
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyText1: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          headline1: TextStyle(
            color: Colors.white,
            fontSize: Platform.isAndroid ? 26 : 20,
            fontWeight: FontWeight.w700,
          ),
          headline2: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
          headline4: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          headline5: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        shadowColor: Colors.grey[700],
      ),
      home: SplashScreen(),
      routes: {
        DrawerZoom.routeName: (ctx) => const DrawerZoom(),
        NewsShow.routeName: (ctx) => NewsShow(),
        BookmarkScreen.routeName: (ctx) => BookmarkScreen(),
        AboutScreen.routeName: (ctx) => AboutScreen(),
        Notifications.routeName: (ctx) => Notifications(),
        OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
      },
    );
  }
}

//Splash Screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      seconds: 2,
    ),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Timer(
        const Duration(
          seconds: 3,
        ),
        () => _navigation(context),
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _navigation(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacementNamed(DrawerZoom.routeName);
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed(OnBoardingScreen.routeName);
      await FirebaseMessaging.instance.subscribeToTopic('flashnews');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/images/splash.png',
            ),
          ),
        ),
      ),
    );
  }
}
