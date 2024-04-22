import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_cubit.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class BmiResultPage extends StatelessWidget {
  final double? bmi;
  const BmiResultPage({super.key, this.bmi});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiCubit(injector(), injector()),
      child:  BmiResultsPageBody(bmi: bmi),
    );
  }
}

class BmiResultsPageBody extends StatefulWidget {
  final double? bmi;
  const BmiResultsPageBody({super.key, this.bmi});

  @override
  State<BmiResultsPageBody> createState() => _BmiResultsPageBodyState();
}

class _BmiResultsPageBodyState extends State<BmiResultsPageBody> {
  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  @override
  void initState() {
    context.read<BmiCubit>().getBmiEntries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Your BMI is',
            style: TextStyle(fontSize: 30, color: Colors.greenAccent),
          ),
          SizedBox(
            height: 20.h,
          ),
          PrettyGauge(
            showMarkers: true,
            gaugeSize: 400,
            currentValue: 10,
            valueWidget: const Text('20'),
            minValue: 0,
            maxValue: 40,
            startMarkerStyle: TextStyle(fontSize: 30.sp,color: Colors.black),
            endMarkerStyle: TextStyle(fontSize: 30.sp,color: Colors.black),
            segments: 
            [
              GaugeSegment('UnderWeight', 18.5, Colors.red),
              GaugeSegment('UnderWeight', 6.4, Colors.green),
              GaugeSegment('UnderWeight', 5, Colors.orange),
              GaugeSegment('UnderWeight', 10.1, Colors.pink),
            ],
          ),
          // const Text(
          //   '21.1',
          //   style: TextStyle(fontSize: 30, color: Colors.greenAccent),
          // ),
          // SizedBox(
          //   height: 20.h,
          // ),
          // const Text(
          //   'This value in the${''}',
          //   style: TextStyle(fontSize: 30, color: Colors.greenAccent),
          // ),
          BlocBuilder<BmiCubit, BmiStates>(
            builder: (context, state) {
              return StreamBuilder(
                  stream: state.bmiEntries,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: Column(
                          children: [
                            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
                            [
                              Text('age'),
                              Text('height'),
                              Text('weight'),
                              Text('bmi'),
                            ],),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Container(
                                      color: Colors.greenAccent,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                        Text(
                                          snapshot.data![index].age .toString(),
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          snapshot.data![index].height.toString(),
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          snapshot.data![index].weight.toString(),
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          snapshot.data![index].bmi.toString(),
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ]));
                                },
                                itemCount: snapshot.data!.length,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  });
            },
          )
        ],
      ),
    );
  }
  void setBmiInterpretation() {
    if (widget.bmi! > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.pink;
    } else if (widget.bmi! >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (widget.bmi! >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (widget.bmi! < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.red;
    }
  }
}

