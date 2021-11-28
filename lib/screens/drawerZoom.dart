import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../main.dart';
import '../screens/news_show.dart';

import '../screens/homepage.dart';
import '../widgets/menuscreen.dart';

class DrawerZoom extends StatefulWidget {
  const DrawerZoom({Key? key}) : super(key: key);

  @override
  _DrawerZoomState createState() => _DrawerZoomState();

  static const routeName = '/drawer';
}

class _DrawerZoomState extends State<DrawerZoom> {
  final _zoomDrawer = ZoomDrawerController();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          var initializationSettingsAndroid =
              const AndroidInitializationSettings('@mipmap/splash');
          var initializationSettings =
              InitializationSettings(android: initializationSettingsAndroid);
          flutterLocalNotificationsPlugin.initialize(
            initializationSettings,
            onSelectNotification: (_) {
              Navigator.of(context).pushNamed(
                NewsShow.routeName,
                arguments: int.parse(
                  message.data['id'],
                ),
              );
            },
          );

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.transparent,
                playSound: true,
                enableVibration: true,
                importance: Importance.high,
                visibility: NotificationVisibility.public,
              ),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.of(context).pushNamed(NewsShow.routeName,
          arguments: int.parse(message.data['id']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        menuScreen: MenuScreen(),
        mainScreen: HomePage(_zoomDrawer),
        controller: _zoomDrawer,
        style: DrawerStyle.Style1,
        backgroundColor: Theme.of(context).shadowColor,
        showShadow: true,
        borderRadius: 20.0,
        angle: 0.0,
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.easeInCubic,
      ),
    );
  }
}
