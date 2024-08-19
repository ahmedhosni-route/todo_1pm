class TaskModel {
  String id;
  String title;
  String desc;
  int date;
  String time;
  bool isDone;
  TaskModel(
      {this.id = "",
      required this.title,
      required this.desc,
      required this.time,
      required this.date,
      required this.isDone});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        date: json["date"],
        time: json["time"],
        isDone: json["isDone"]);
  }

  // TaskModel.fromJson(Map<String, dynamic> json)
  //     : id = json["id"],
  //       title = json["title"],
  //       desc = json["desc"],
  //       time = json["time"],
  //       isDone = json["isDone"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "date": date,
      "time": time,
      "isDone": isDone
    };
  }
}
