class NotificationModel {
  String? senderName;
  String? senderImage;
  String? dateTime;

  NotificationModel(
      {required this.senderName,
      required this.senderImage,
      required this.dateTime});

  NotificationModel.fromJson(Map<String, dynamic>? json) {
    senderName = json!['senderName'];
    senderImage = json['senderImage'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderName'] = senderName;
    data['senderImage'] = senderImage;
    data['dateTime'] = dateTime;
    return data;
  }
}
