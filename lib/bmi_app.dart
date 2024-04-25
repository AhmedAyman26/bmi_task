import 'package:bmi_task/core/utils/cache_helper.dart';
import 'package:bmi_task/features/authentication/presentation/login_page.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BMIApp extends StatelessWidget {
  const BMIApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = CacheHelper.getData(key: 'userId');
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: userId != null ?  const BmiPage() : const SignInPage(),
      ),
    );
  }
}