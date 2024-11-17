import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseNotificationService._();
  static FirebaseNotificationService instance = FirebaseNotificationService._();
  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //terminated
    FirebaseMessaging.onBackgroundMessage(doNothing);

    String? token = await getToken();
    print(token);
  }

  Future<void> doNothing(RemoteMessage remoteMessage) async {}

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}
