import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showLoading(context)
{
  return showDialog(
    context: context,
    builder: (context)=> AlertDialog(
      title: const Text('please wait'),
      content: SizedBox(
          height: 50.h,
          child: const Center(child: CircularProgressIndicator(),)),
    ),
  );
}