import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/drawerZoom.dart';

class Notifications extends StatefulWidget {
  static const routeName = '/subscribe';

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isNational = false;
  bool isPolitic = false;
  bool isEconomic = false;
  bool isInternational = false;
  bool isTechnology = false;
  bool isSport = false;
  bool isEntertainment = false;
  bool isWriting = false;
  bool isHealth = false;

  @override
  void initState() {
    super.initState();
    getAllSavedData();
  }

  getAllSavedData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    isNational = (_prefs.getBool('isNational') ?? false);
    isPolitic = (_prefs.getBool('isPolitic') ?? false);
    isEconomic = (_prefs.getBool('isEconomic') ?? false);
    isEntertainment = (_prefs.getBool('isEntertainment') ?? false);
    isInternational = (_prefs.getBool('isInternational') ?? false);
    isSport = (_prefs.getBool('isSport') ?? false);
    isTechnology = (_prefs.getBool('isTechnology') ?? false);
    isWriting = (_prefs.getBool('isWriting') ?? false);
    isHealth = (_prefs.getBool('isHealth') ?? false);
    setState(() {});
  }

  subscribe(String title) async {
    await FirebaseMessaging.instance.subscribeToTopic(title);
  }

  unsbscribe(String title) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(title);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Notifications'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.05,
                vertical: mediaQuery.height * 0.05,
              ),
              child: const Center(
                child: Text(
                  'Get Notification For Your Favroite Topics',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Wrap(
              spacing: 15.0,
              children: [
                ActionChip(
                  label: Text(
                    'राष्ट्रिय',
                    style: TextStyle(
                      color: isNational ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isNational
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _seen = (_prefs.getBool('isNational') ?? false);
                    setState(() {
                      if (_seen) {
                        isNational = false;
                        _prefs.setBool('isNational', false);
                        _seen = (_prefs.getBool('isNational') ?? false);
                      } else {
                        isNational = true;
                        _prefs.setBool('isNational', true);
                        _seen = (_prefs.getBool('isNational') ?? false);
                      }
                    });
                    if (_seen) {
                      subscribe('national');
                    } else {
                      unsbscribe('national');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'राजनिती',
                    style: TextStyle(
                      color: isPolitic ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isPolitic
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _politic = (_prefs.getBool('isPolitic') ?? false);
                    setState(() {
                      if (_politic) {
                        isPolitic = false;
                        _prefs.setBool('isPolitic', false);
                        _politic = (_prefs.getBool('isPolitic') ?? false);
                      } else {
                        isPolitic = true;
                        _prefs.setBool('isPolitic', true);
                        _politic = (_prefs.getBool('isPolitic') ?? false);
                      }
                    });
                    if (_politic) {
                      subscribe('politics');
                    } else {
                      unsbscribe('politics');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'अर्थ-राेजगार',
                    style: TextStyle(
                      color: isEconomic ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isEconomic
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _economic = (_prefs.getBool('isEconomic') ?? false);
                    setState(() {
                      if (_economic) {
                        isEconomic = false;
                        _prefs.setBool('isEconomic', false);
                        _economic = (_prefs.getBool('isEconomic') ?? false);
                      } else {
                        isEconomic = true;
                        _prefs.setBool('isEconomic', true);
                        _economic = (_prefs.getBool('isEconomic') ?? false);
                      }
                    });
                    if (_economic) {
                      subscribe('eco');
                    } else {
                      unsbscribe('eco');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'अन्तराष्ट्रिय',
                    style: TextStyle(
                      color: isInternational ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isInternational
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _international =
                        (_prefs.getBool('isInternational') ?? false);
                    setState(() {
                      if (_international) {
                        isInternational = false;
                        _prefs.setBool('isInternational', false);
                        _international =
                            (_prefs.getBool('isInternational') ?? false);
                      } else {
                        isInternational = true;
                        _prefs.setBool('isInternational', true);
                        _international =
                            (_prefs.getBool('isInternational') ?? false);
                      }
                    });
                    if (_international) {
                      subscribe('international');
                    } else {
                      unsbscribe('international');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'स्वास्थ्य',
                    style: TextStyle(
                      color: isHealth ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isHealth
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _isHealth = (_prefs.getBool('isHealth') ?? false);
                    setState(() {
                      if (_isHealth) {
                        isHealth = false;
                        _prefs.setBool('isHealth', false);
                        _isHealth = (_prefs.getBool('isHealth') ?? false);
                      } else {
                        isHealth = true;
                        _prefs.setBool('isHealth', true);
                        _isHealth = (_prefs.getBool('isHealth') ?? false);
                      }
                    });
                    if (_isHealth) {
                      subscribe('isHealth');
                    } else {
                      unsbscribe('isHealth');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'सुचना-प्रविधि',
                    style: TextStyle(
                      color: isTechnology ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isTechnology
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _technology =
                        (_prefs.getBool('isTechnology') ?? false);
                    setState(() {
                      if (_technology) {
                        isTechnology = false;
                        _prefs.setBool('isTechnology', false);
                        _technology = (_prefs.getBool('isTechnology') ?? false);
                      } else {
                        isTechnology = true;
                        _prefs.setBool('isTechnology', true);
                        _technology = (_prefs.getBool('isTechnology') ?? false);
                      }
                    });
                    if (_technology) {
                      subscribe('technology');
                    } else {
                      unsbscribe('technology');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'खेलकुद',
                    style: TextStyle(
                      color: isSport ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isSport
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _sport = (_prefs.getBool('isSport') ?? false);
                    setState(() {
                      if (_sport) {
                        isSport = false;
                        _prefs.setBool('isSport', false);
                        _sport = (_prefs.getBool('isSport') ?? false);
                      } else {
                        isSport = true;
                        _prefs.setBool('isSport', true);
                        _sport = (_prefs.getBool('isSport') ?? false);
                      }
                    });
                    if (_sport) {
                      subscribe('sports');
                    } else {
                      unsbscribe('sports');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'मनाेरञ्जन',
                    style: TextStyle(
                      color: isEntertainment ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isEntertainment
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _entertainment =
                        (_prefs.getBool('isEntertainment') ?? false);
                    setState(() {
                      if (_entertainment) {
                        isEntertainment = false;
                        _prefs.setBool('isEntertainment', false);
                        _entertainment =
                            (_prefs.getBool('isEntertainment') ?? false);
                      } else {
                        isEntertainment = true;
                        _prefs.setBool('isEntertainment', true);
                        _entertainment =
                            (_prefs.getBool('isEntertainment') ?? false);
                      }
                    });
                    if (_entertainment) {
                      subscribe('entertainment');
                    } else {
                      unsbscribe('entertainment');
                    }
                  },
                  pressElevation: 1,
                ),
                ActionChip(
                  label: Text(
                    'लेख',
                    style: TextStyle(
                      color: isWriting ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isWriting
                      ? const Color.fromRGBO(
                          34,
                          45,
                          102,
                          1,
                        )
                      : Colors.grey[350],
                  onPressed: () async {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    bool _writing = (_prefs.getBool('isWriting') ?? false);
                    setState(() {
                      if (_writing) {
                        isWriting = false;
                        _prefs.setBool('isWriting', false);
                        _writing = (_prefs.getBool('isWriting') ?? false);
                      } else {
                        isWriting = true;
                        _prefs.setBool('isWriting', true);
                        _writing = (_prefs.getBool('isWriting') ?? false);
                      }
                    });

                    if (_writing) {
                      subscribe('articles');
                    } else {
                      unsbscribe('articles');
                    }
                  },
                  pressElevation: 1,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: mediaQuery.height * 0.2,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(DrawerZoom.routeName);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
