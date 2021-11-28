import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about-us';

  Widget info(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            child: Get.isDarkMode
                ? Image.asset('assets/images/dark_logo.png')
                : Image.asset('assets/images/logo.png'),
          ),
          info(
            context,
            'Email:',
            'info@sanchardainik.com.np',
          ),
          const SizedBox(
            height: 10,
          ),
          info(context, 'Phone:', '+977-56-596250'),
          const SizedBox(
            height: 10,
          ),
          info(context, 'Address:', 'Bharatpur-3, Chitwan'),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.red,
            thickness: 1,
          ),
          const Text('Copyright © 2021, Sanchar Dainik. All rights reserved.'),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Powered by Bitmap I.T. Solution Pvt. Ltd..'),
          ),
        ],
      ),
    );
  }
}
