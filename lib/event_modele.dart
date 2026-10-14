class EventModel {
  String id;
  String categoryId;
  String date;
  String desc;
  String time;
  String title;

  EventModel({
    required this.id,
    required this.categoryId,
    required this.date,
    required this.desc,
    required this.time,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "categoryId": categoryId,
      "date": date,
      "time": time,
      "desc": desc,
      "title": title,
    };
  }
}