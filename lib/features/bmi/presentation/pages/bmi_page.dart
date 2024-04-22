import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/core/widgets/app_button.dart';
import 'package:bmi_task/core/widgets/app_text_form_field.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_cubit.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_results_page.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_states.dart';
import 'package:bmi_task/features/bmi/presentation/widgets/gender_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BmiPage extends StatelessWidget {
  const BmiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiCubit(injector(),injector()),
      child: const BmiPageBody(),
    );
  }
}

class BmiPageBody extends StatefulWidget {
  const BmiPageBody({super.key});

  @override
  State<BmiPageBody> createState() => _BmiPageBodyState();
}

class _BmiPageBodyState extends State<BmiPageBody> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Lets Calculate\nYour Current BMI',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'You can find out whether you are underweight, normal, overweight or obese based on your BMI',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const GenderSelectionWidget(),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        controller: ageController,
                        hintText: 'Age',
                        label: 'Age',
                        validate: (p0) {
                          if (p0!.isEmpty) {
                            return 'Age cannot be empty';
                          }
                          return null;
                        },
                      ),
                      AppTextFormField(
                        controller: heightController,
                        hintText: 'Height',
                        suffix: Text('m'),
                        label: 'Height',
                        validate: (p0) {
                          if (p0!.isEmpty) {
                            return 'Height cannot be empty';
                          }
                          return null;
                        },
                      ),
                      AppTextFormField(
                        controller: weightController,
                        hintText: 'Weight',
                        suffix: Text('kg'),
                        label: 'Weight',
                        validate: (p0) {
                          if (p0!.isEmpty) {
                            return 'Weight cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<BmiCubit, BmiStates>(
          listener: (context, state) {
            if (state.addBmiEntriesStatus == RequestStatus.success) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BmiResultPage(),));
            }
          },
          builder: (context, state) {
            return AppButton(text: 'Calculate BMI', function: () {
              if (formKey.currentState!.validate()) {
                BlocProvider
                    .of<BmiCubit>(context).calculateBmi(BMIEntriesModel(
                    height: double.parse(heightController.text),
                    weight: double.parse(weightController.text),
                    age: double.parse(ageController.text),
                    bmi: state.bmi ?? 0.0,
                    dateTime: DateTime.now().millisecondsSinceEpoch));
                BlocProvider
                    .of<BmiCubit>(context)
                    .addBmiEntries(BMIEntriesModel(
                    height: double.parse(heightController.text),
                    weight: double.parse(weightController.text),
                    age: double.parse(ageController.text),
                    bmi: state.bmi ?? 0.0,
                    dateTime: DateTime.now().millisecondsSinceEpoch));
              }
            }, radius: 30,);
          },
        ),
      ),
    );
  }
}