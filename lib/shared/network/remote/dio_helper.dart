

import 'package:dio/dio.dart';

import '../../../models/user_model.dart';

class DioHelper{
  static late Dio dio ;

  static init(){
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://fcm.googleapis.com/fcm/',
          receiveDataWhenStatusError: true,
          connectTimeout: 50000 ,
          sendTimeout: 50000,
          validateStatus: (status){return status! < 500;},
        )
    );
  }


  static Future<Response> postData({
    String path = 'send',
    required UserModel senderUser ,
    required String dateTime,
    required String receiverToken,

  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'Authorization' : 'key=AAAAANkLtXw:APA91bHjE0QzdmPwZtPwpoMe3NBIyNS-K6S9ErNMOc89lilpILHVsHH9jzYF2yWs0TO3rfW6N52w62MH4XpDDvInSVbSQgra8t4KGiqIfGWDy87LPM5J1xM4xvK_ws-RAOmxDVEJxhkI' ,
    };

    Map<String, dynamic> data = {
      "data": {
        "senderUser":"${senderUser.name}",
        "senderImage":"${senderUser.image}",
        "dateTime": dateTime,
        "click_action":"FLUTTER_NOTIFICATION_CLICK"
      },
      "to": receiverToken,
      "notification": {
        "title":"You have received a message from ${senderUser.name}",
        "body":"open Message",
        "sound":"default"

      },
      "android":{
        "priority":"HIGH",
        "notification":{
          "notification_priority":"PRIORITY_MAX",
          "sound":"default",
          "default_sound":true,
          "default_vibrate_timings":true,
          "default_light_settings":true
        }
      }
    };

    return await dio.post(path,data: data);
  }




}