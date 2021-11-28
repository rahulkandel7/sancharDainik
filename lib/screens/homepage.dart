import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../controllers/NewsController.dart';
import '../widgets/news_list.dart';
import '../controllers/CategoryController.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  final zoomDrawerController;
  HomePage(this.zoomDrawerController);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categoryController = Get.put(CategoryController());
  final newsController = Get.put(NewsController());

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  initState() {
    super.initState();
    categoryController.fetchCategory();
    newsController.fetchNews();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Widget title(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Text(
        text,
      ),
    );
  }

  Future<dynamic> _onRefresh(BuildContext context) async {
    await newsController.fetchNews();
  }

  Widget newsLists(BuildContext context, String catName) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      color: Colors.indigo.shade700,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, i) {
          return Obx(
            () {
              int catId = newsController.getCategoryID(catName);
              if (newsController.news[i].category_id == catId) {
                return NewsList(
                  id: newsController.news[i].id,
                  title: newsController.news[i].news_heading,
                  description: newsController.news[i].news_content,
                  image: newsController.news[i].photopath,
                  date: newsController.news[i].news_date,
                  writer: newsController.news[i].writer,
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
        itemCount: newsController.news.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              widget.zoomDrawerController.toggle();
            },
            icon: Icon(
              Platform.isAndroid ? Icons.menu : CupertinoIcons.bars,
              size: 28,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: SizedBox(
              width: mediaQuery.width * 0.2,
              child: Get.isDarkMode
                  ? Image.asset(
                      'assets/images/dark_logo.png',
                    )
                  : Image.asset('assets/images/logo.png'),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            enableFeedback: true,
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.label,
            physics: const BouncingScrollPhysics(),
            // overlayColor: MaterialStateProperty.all<Color>(Colors.red),
            indicator: BoxDecoration(
              color: const Color.fromRGBO(34, 45, 102, 1),
              borderRadius: BorderRadius.circular(5),
            ),

            labelPadding:
                const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
            labelStyle: TextStyle(
              fontSize: Platform.isAndroid ? 18 : 15,
            ),
            tabs: [
              title('राष्ट्रिय', context),
              title('राजनिती', context),
              title('अर्थ-राेजगार', context),
              title('अन्तराष्ट्रिय', context),
              title('स्वास्थ्य', context),
              title('सुचना-प्रविधि', context),
              title('खेलकुद', context),
              title('मनाेरञ्जन', context),
              title('लेख', context),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (Get.isDarkMode) {
                  Get.changeThemeMode(ThemeMode.light);
                } else {
                  Get.changeThemeMode(ThemeMode.dark);
                }
              },
              icon: Icon(
                Platform.isAndroid
                    ? Icons.brightness_4_outlined
                    : CupertinoIcons.brightness_solid,
              ),
            )
          ],
        ),
        body: _connectionStatus == ConnectivityResult.none
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/nointernet.webp'),
                    Text(
                      'oops! No Internet Connection',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Goto Bookmark for Offline Reading',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : FutureBuilder(
                future: newsController.fetchNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return TabBarView(
                      children: [
                        newsLists(context, 'राष्ट्रिय'),
                        newsLists(context, 'राजनिती'),
                        newsLists(context, 'अर्थ-राेजगार'),
                        newsLists(context, 'अन्तराष्ट्रिय'),
                        newsLists(context, 'स्वास्थ्य'),
                        newsLists(context, 'सुचना-प्रविधि'),
                        newsLists(context, 'खेलकुद'),
                        newsLists(context, 'मनाेरञ्जन'),
                        newsLists(context, 'लेख'),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
      ),
    );
  }
}
