class ChatModel {
  int? id;
  String? message;
  String? date;
  String? from;
  String? to;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'message': message,
      'date': date,
      'from': from,
      'to': to,
    };
    return map;
  }

  fromMap(Map<String, dynamic> valueDB) {
    id = valueDB['id'];
    message = valueDB['message'];
    date = valueDB['date'];
    from = valueDB['from'];
    to = valueDB['to'];
  }
}
