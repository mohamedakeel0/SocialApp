

import 'package:bloc/bloc.dart';
import 'package:firebase1/layout/cubic/states.dart';
import 'package:firebase1/shared/bloc_observer/blocObserver.dart';
import 'package:firebase1/shared/componnents0/Constants.dart';
import 'package:firebase1/shared/componnents0/components.dart';
import 'package:firebase1/shared/network/local/cache_helper.dart';
import 'package:firebase1/shared/network/style/Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layout/Social_layout.dart';
import 'layout/cubic/cubic.dart';
import 'modules/Login/social_login.dart';
import 'package:flutter/material.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('onBackgroundMessageOpenedApp');
  print(message.data.toString());
  ShowToast(text: 'on Background Message ', state: Toaststates.SUCCESS);
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var  token=await FirebaseMessaging.instance.getToken();
  print(token);
await FirebaseMessaging.onMessage.listen((event) {
  print('onMessage');
  print(event.data.toString());
  ShowToast(text: 'onMessage', state: Toaststates.SUCCESS);
});
 await FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('onMessageOpenedApp');
    print(event.data.toString());
    ShowToast(text: 'on Message Opened App', state: Toaststates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SharedPreferences.getInstance();
  Bloc.observer = MyBlocObserver();


  await CacheHelper.init();
  Widget widget;
  uId=CacheHelper.getData(key: 'uId');
  if(uId!=null){

    widget=Socail_layout();
  }else{
    widget=SocialLogin();
  }

  runApp( MyApp(startWidget:widget));

}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({required this.startWidget}) ;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( BuildContext context)=>SocailCubic()..getUserData()..getposts()..getUsers()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget ,
      ),
    );
  }
}
