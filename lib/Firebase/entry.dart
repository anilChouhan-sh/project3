class Entry {
  final String title;
  final String description;
  final String date;
  final whom;
  final String id;
  final String userid;
  final bool done;
  Entry(
      {this.title,
      this.description,
      this.date,
      this.whom,
      this.id,
      this.userid,
      this.done});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        title: json['title'],
        description: json['description'],
        date: json['date'],
        whom: json['whom'],
        id: json['id'],
        userid: json['userid'],
        done: json['done']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'whom': whom,
      'id': id,
      'userid': userid,
      'done': done
    };
  }
}
