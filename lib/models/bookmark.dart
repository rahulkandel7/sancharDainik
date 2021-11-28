final String table = "tbl_bookmark";

class BookmarkFileds {
  static final List<String> values = [
    id,
    title,
    description,
    categoryName,
    image,
    date,
    writer
  ];

  static final String id = 'id';
  static final String title = 'title';
  static final String description = 'description';
  static final String categoryName = 'categoryName';
  static final String image = 'image';
  static final String date = 'date';
  static final String writer = 'writer';
}

class Bookmark {
  final int id;
  final String title;
  final String description;
  final String categoryName;
  final String image;
  final String date;
  final String writer;

  Bookmark({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.image,
    required this.date,
    required this.writer,
  });

  static Bookmark fromJson(Map<String, Object?> json) => Bookmark(
        id: json[BookmarkFileds.id] as int,
        title: json[BookmarkFileds.title] as String,
        description: json[BookmarkFileds.description] as String,
        categoryName: json[BookmarkFileds.categoryName] as String,
        image: json[BookmarkFileds.image] as String,
        date: json[BookmarkFileds.date] as String,
        writer: json[BookmarkFileds.writer] as String,
      );

  Map<String, dynamic> toJson() => {
        BookmarkFileds.id: id,
        BookmarkFileds.title: title,
        BookmarkFileds.description: description,
        BookmarkFileds.categoryName: categoryName,
        BookmarkFileds.image: image,
        BookmarkFileds.date: date,
        BookmarkFileds.writer: writer,
      };

  Bookmark copy({
    int? id,
    String? title,
    String? description,
    String? categoryName,
    String? image,
    String? date,
    String? writer,
  }) =>
      Bookmark(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        categoryName: categoryName ?? this.categoryName,
        image: image ?? this.image,
        date: date ?? this.date,
        writer: writer ?? this.writer,
      );
}
