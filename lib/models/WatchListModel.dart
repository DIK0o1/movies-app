class WatchListModel {
  int id;

  String image;

  String title;

  String content;

  String date;

  bool check;

  WatchListModel({
    required this.id,
    required this.image,
    required this.title,
    required this.content,
    required this.date,
    required this.check,
  });

  WatchListModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] as int,
          image: json['image'] as String,
          title: json['title'] as String,
          content: json['content'] as String,
          date: json['date'] as String,
          check: json['check'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'content': content,
      'date': date,
      'check': check,
    };
  }
}
