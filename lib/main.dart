import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/view/gift_tracker_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  runApp(const GiftTrackerApp());
}

class GiftTrackerApp extends StatelessWidget {
  const GiftTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Gift Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: const Color(0xFFF7F7F7),
          ),
          home: const GiftTrackerHomePage(),
        );
      },
    );
  }
}
