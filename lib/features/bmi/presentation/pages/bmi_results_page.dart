import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/core/widgets/app_button.dart';
import 'package:bmi_task/core/widgets/app_text_form_field.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_cubit.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      create: (context) => BmiCubit(),
      child: BmiResultsPageBody(bmi: bmi),
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

  DocumentSnapshot? lastDocument;
  bool isLastPage = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    setBmiInterpretation();
    context.read<BmiCubit>().getBmiEntries();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
          context.read<BmiCubit>().loadMoreEntries(lastDocument);
        
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Your BMI is',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            SizedBox(
              height: 20.h,
            ),
            PrettyGauge(
              showMarkers: true,
              gaugeSize: 400,
              currentValue: widget.bmi,
              valueWidget: Column(
                children: [
                  Text(
                    widget.bmi?.toStringAsFixed(1) ?? '',
                    style: TextStyle(fontSize: 30.sp, color: Colors.black),
                  ),
                  Text(bmiStatus ?? '',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: bmiStatusColor,
                      )),
                ],
              ),
              minValue: 0,
              maxValue: 40,
              startMarkerStyle: TextStyle(fontSize: 25.sp, color: Colors.black),
              endMarkerStyle: TextStyle(fontSize: 25.sp, color: Colors.black),
              segments: [
                GaugeSegment('UnderWeight', 18.5, Colors.red),
                GaugeSegment('UnderWeight', 6.4, Colors.green),
                GaugeSegment('UnderWeight', 5, Colors.orange),
                GaugeSegment('UnderWeight', 10.1, Colors.pink),
              ],
            ),
            BlocBuilder<BmiCubit, BmiStates>(
              builder: (context, state) {
                if (state.getBmiEntriesState == RequestStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.getBmiEntriesState == RequestStatus.success) {
                  if (state.bmiEntries!.isEmpty) {
                    return const Center(
                      child: Text('No Entries yet'),
                    );
                  } else {
                    lastDocument = state.bmiEntries?.last.documentSnapshot;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.grey,
                                        blurRadius: 5)
                                  ]),
                              child: const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text('age')),
                                  Expanded(child: Text('height')),
                                  Expanded(child: Text('weight')),
                                  Expanded(child: Text('bmi')),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    state.bmiEntries?[index].age
                                                        .toString() ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    state.bmiEntries?[index]
                                                        .height
                                                        .toString() ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    state.bmiEntries?[index]
                                                        .weight
                                                        .toString() ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    state.bmiEntries?[index].bmi
                                                        ?.toStringAsFixed(1)
                                                        .toString() ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    context.read<BmiCubit>()
                                                        .deleteEntry(state
                                                        .bmiEntries?[index]
                                                        .id ?? '');
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ]);
                                        },
                                      ));
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 1,
                                    thickness: 1,
                                  );
                                },
                                itemCount: state.bmiEntries?.length ?? 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
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
