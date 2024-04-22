import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_cubit.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BmiResultPage extends StatelessWidget {
  const BmiResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiCubit(injector(), injector()),
      child: const BmiResultsPageBody(),
    );
  }
}

class BmiResultsPageBody extends StatefulWidget {
  const BmiResultsPageBody({super.key});

  @override
  State<BmiResultsPageBody> createState() => _BmiResultsPageBodyState();
}

class _BmiResultsPageBodyState extends State<BmiResultsPageBody> {
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
          const Text(
            '21.1',
            style: TextStyle(fontSize: 30, color: Colors.greenAccent),
          ),
          SizedBox(
            height: 20.h,
          ),
          const Text(
            'This value in the${''}',
            style: TextStyle(fontSize: 30, color: Colors.greenAccent),
          ),
          BlocBuilder<BmiCubit, BmiStates>(
            builder: (context, state) {
              return StreamBuilder(
                  stream: state.bmiEntries,
                  builder: (context, snapshot) {
                    print("SADASDasdassadas${snapshot.error}");
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                                color: Colors.greenAccent,
                                child: Row(children: [
                                  Text(
                                    snapshot.data![index].bmi.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ]));
                          },
                          itemCount: snapshot.data!.length,
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
}
