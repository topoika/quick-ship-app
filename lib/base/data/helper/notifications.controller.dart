part of "../data.dart";

FlutterLocalNotificationsPlugin localNotifications =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging fcm = FirebaseMessaging.instance;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notification) {
  final String? payload = notification.payload;
  if (payload != null) {
    Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.notifications);
  }
}

class NotificationService extends FCMData {
  static initializePlugin() async {
    try {
      const DarwinInitializationSettings ios = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      AndroidInitializationSettings androidSettings =
          const AndroidInitializationSettings('@mipmap/notifications');
      final InitializationSettings initializationSettings =
          InitializationSettings(
        iOS: ios,
        android: androidSettings,
      );
      await localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
      await localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channelAndroid);
    } catch (ex) {
      log('EXCEPTION: $ex');
    }
  }

  // request permission
  static Future<void> requestPermission() async {
    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static onDidReceiveNotificationResponse(
      NotificationResponse notification) async {
    final String? payload = notification.payload;

    if (payload != null) {
      final Map<String, dynamic> payloadMap = json.decode(payload);
      AppNotifications notification = AppNotifications.fromMap(payloadMap);
      navigateNoTification(notification: notification);
    }
  }

  // firebase messaging
  Future setupFCMListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showNotification(message: message);
    });
    await fcm.subscribeToTopic("all").catchError((e) => log(e.toString()));
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppNotifications notification = AppNotifications.fromMap(message.data);
      navigateNoTification(notification: notification);
    });
  }

  showNotification({required RemoteMessage message}) async {
    AppNotifications item = AppNotifications.fromMap(message.data);
    await localNotifications.show(
      item.userId ?? message.hashCode,
      item.title,
      item.body,
      platFormSpecs,
      payload: json.encode(message.data),
    );
  }

  static Future<void> navigateNoTification(
      {required AppNotifications notification, bool? terminate}) async {
    final bool isAuthorized = Storage.getData("authToken") != null;

    String route = isAuthorized ? AppRoutes.tabs : AppRoutes.login;
    dynamic args;

    if (isAuthorized) {
      switch (notification.type) {
        case "message":
          String? chatId = conversationId(notification.itemId!);
          if (await setConversation(chatId)) {
            route = AppRoutes.conversationPage;
            args = true;
          } else {
            args = 3;
          }
          break;

        case "order" || "response" || "request":
          route = AppRoutes.notifications;
          break;
        default:
          break;
      }
    }
    Navigator.pushReplacementNamed(navigatorKey.currentContext!, route,
        arguments: args ?? 0);
  }

  static Future<bool> setConversation(String id) async {
    try {
      final doc = await db.collection("chats").doc(id).get();
      if (!doc.exists) return false;
      final convoData = doc.data() as Map<String, dynamic>;
      final convo = Conversation.fromMap(convoData);
      final activeUserId = activeUser.value.id;

      final otherUser =
          convo.participants!.firstWhere((u) => u.id != activeUserId);

      final chatCubit = navigatorKey.currentContext!.read<ChatCubit>();
      chatCubit.setConversation(convo);
      chatCubit.setOtherUser(otherUser);
      return true;
    } catch (e) {
      log("Error setting conversation: $e");
      return false;
    }
  }
}

AndroidNotificationChannel channelAndroid = AndroidNotificationChannel(
  'quick_ship_app',
  'Quick Ship',
  description: 'Quick Ship Notifications',
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
  showBadge: true,
  vibrationPattern: Int64List.fromList([0, 200, 0, 200]),
  sound: const RawResourceAndroidNotificationSound('notifications_sound'),
);

// ios channel
DarwinNotificationCategory iosChannel =
    const DarwinNotificationCategory('auto_cllan_channel');

class FCMData {
  static AndroidNotificationDetails androidSpecs = AndroidNotificationDetails(
    "quick_ship_app",
    'Quick Ship',
    channelDescription: 'Quick Ship Notifications',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/notifications',
    playSound: true,
    enableVibration: false,
    vibrationPattern: Int64List.fromList([0, 500, 0, 500]),
    sound: const RawResourceAndroidNotificationSound("notifications_sound"),
  );

// ios notification details
  static DarwinNotificationDetails iosSpecs = const DarwinNotificationDetails(
      threadIdentifier: 'quick_ship_app',
      presentSound: true,
      presentAlert: true,
      presentBadge: true);

  NotificationDetails platFormSpecs = NotificationDetails(
    android: androidSpecs,
    iOS: iosSpecs,
  );
}

Future<void> backgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
