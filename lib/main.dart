import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/responsives/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsives/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsives/web_screen_layout.dart';
import 'package:instagram_flutter/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyA9nKx8bE1RYQ_qUDvADldGStG5DwBPM_4',
          appId: '1:17597645264:web:242bb665cb64f153a879d5',
          messagingSenderId: '17597645264',
          projectId: 'my-instagram-dd2c2',
          storageBucket: 'my-instagram-dd2c2.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      title: 'Instagram Clone',
      home: const ResponsiveLayoutScreen(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    );
  }
}
