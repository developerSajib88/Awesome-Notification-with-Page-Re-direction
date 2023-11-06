import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:untitled16/notification_controller.dart';
import 'package:untitled16/second_screen.dart';

void main()async{
  try{
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true
    );
  }catch(e,error){
    print('e>>>>>>>>>>$e');
    print('e>>>>>>>>>>$error');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }else{
        AwesomeNotifications().setListeners(
            onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
            onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
            onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
            onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod,
        );
      }
    });





  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Awesome Notification"),
      ),

      body: Center(

        child: ElevatedButton(
          onPressed: (){
            AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 10,
                  largeIcon: "asset://assets/images/logo.png",
                  bigPicture: "asset://assets/images/caretutors_meta.jpg",
                  notificationLayout: NotificationLayout.BigPicture,
                  channelKey: 'basic_channel',
                  actionType: ActionType.Default,
                  title: 'Congratulation! You are selected',
                  body: 'Now you are selected as a junior developer. Welcome aboard',
                  payload: {"name" : "Second screen"},
                ),
            );
          },
          child: const Text("Send Notification"),
        )
      ),
    );
  }
}
