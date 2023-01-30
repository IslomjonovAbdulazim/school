import 'package:ds/firebase_options.dart';
import 'package:ds/pages/director/bnb/bnb_page.dart';
import 'package:ds/pages/guest/bnb/bnb_page.dart';
import 'package:ds/pages/guest_web/bnb/bnb_page.dart';
import 'package:ds/pages/log_in/log_in_page.dart';
import 'package:ds/pages/teacher/bnb/bnb_page.dart';
import 'package:ds/utils/keys.dart';
import 'package:ds/utils/lan.dart';
import 'package:ds/utils/titles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'services/fb_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  lan.init();
  t.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: auth.stream(),
        builder: (context, snapshot) {
          // auth.signOut();
          // return const DBNBPage();
          if (snapshot.hasData) {
            if (snapshot.data!.email!.endsWith('.${keys.director}@gmail.com')) {
              return const DBNBPage();
            } else if (snapshot.data!.email!
                .endsWith('.${keys.teacher}@gmail.com')) {
              return const TBNBPage();
            }
            return const SizedBox.shrink();
          }
          return const LogInPage();
        },
      ),//
    );
  }
}
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  };
}