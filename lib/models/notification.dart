class notification {
  String? date;
  String? message;
  bool read;
  notification({
    required this.date,
    required this.message,
    this.read = false,
  });

  notification.fromMap(Map map)
      : this.date = map['date'],
        this.message = map['message'],
        this.read = map['read'];

  Map toMap() {
    return {
      'date': this.date,
      'message': this.message,
      'read': this.read,
    };
  }
}
