import '../../models/notificationModel.dart';

String? uId;

 List<NotificationModel> notificationList =[];

String daysBetween(DateTime postDate) {
  if ((DateTime.now().difference(postDate).inHours / 24).round() == 0) {
    if (DateTime.now().difference(postDate).inHours == 0) {
      if (DateTime.now().difference(postDate).inMinutes == 0) {
        return 'now';
      } else {
        return '${DateTime.now().difference(postDate).inMinutes.toString()}m';
      }
    } else {
      return '${DateTime.now().difference(postDate).inHours.toString()}h';
    }
  } else {
    return (' ${(DateTime.now().difference(postDate).inHours / 24).round().toString()}d');
  }
}
