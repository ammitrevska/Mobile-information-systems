import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lab_2/main.dart';

class FirebaseApi {
  // create an instancec of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // initialize notifications
  Future<void> initNotifications() async {
    //request permission from user 
    await _firebaseMessaging.requestPermission();

    // fetch FCM token for this device 
    final fCMToken = await _firebaseMessaging.getToken();

    print(fCMToken);

  }

  // handle received messages 
  void handleMessage(RemoteMessage? message){
    if(message == null) return;

    // navigate to fave jokes screen when user recives the messsage and taps on it
    navigatorKey.currentState?.pushNamed('/jokeOfTheDay', arguments: message);
  }

  Future initPushNotifications() async{

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}