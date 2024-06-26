import 'package:bmi_task/bmi_app.dart';
import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/core/utils/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await CacheHelper.init();
  await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: 'AIzaSyD9Efd_n2PQ1qqeTxwengQz0Cw6LD6i8TA',
    appId: '1:738954420065:android:e04e0a7b1fb75784976f20',
    messagingSenderId: '738954420065',
    projectId: 'bmi-task-60081',
    storageBucket: 'bmi-task-60081.appspot.com',
  ));
  runApp(const BMIApp());
}

