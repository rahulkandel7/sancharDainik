import 'package:flutter/material.dart';

import '../database/bookmark_database.dart';
import '../models/bookmark.dart';
import '../widgets/bookmark_list.dart';

class BookmarkScreen extends StatefulWidget {
  static const routeName = '/bookmark';

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late List<Bookmark> bookmark;

  @override
  void initState() {
    super.initState();
    refreshBookmark();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshBookmark();
  }

  refreshBookmark() async {
    bookmark = await BookmarkDatabase.instance.readAllBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: refreshBookmark(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (bookmark.isEmpty) {
              return const Center(
                child: Text(
                  'You have not any Bookmark Yet',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  return BookmarkList(
                    id: bookmark[i].id,
                    title: bookmark[i].title,
                    description: bookmark[i].description,
                    image: bookmark[i].image,
                  );
                },
                itemCount: bookmark.length,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
