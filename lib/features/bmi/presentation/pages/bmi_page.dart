import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/core/widgets/app_button.dart';
import 'package:bmi_task/core/widgets/app_text_form_field.dart';
import 'package:bmi_task/core/widgets/show_loading_widget.dart';
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
      create: (context) => BmiCubit(),
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

  double bmi = 0;
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
                        type: TextInputType.number,
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
                        type: TextInputType.number,
                        controller: heightController,
                        hintText: 'Height',
                        suffix: const Text('m'),
                        label: 'Height',
                        validate: (p0) {
                          if (p0!.isEmpty) {
                            return 'Height cannot be empty';
                          }
                          return null;
                        },
                      ),
                      AppTextFormField(
                        type: TextInputType.number,
                        controller: weightController,
                        hintText: 'Weight',
                        suffix: const Text('kg'),
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
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  BmiResultPage(bmi: bmi),));
            }
            if(state.addBmiEntriesStatus == RequestStatus.loading){
              showLoading(context);
            }
          },
          builder: (context, state) {
            return AppButton(text: 'Calculate BMI', function: () {
              final bmiEntry = BMIEntriesModel(
                height: double.parse(heightController.text),
                weight: double.parse(weightController.text),
                age: ageController.text,
                dateTime: DateTime.now().toString(),
              );
              if (formKey.currentState!.validate()) {
               bmi = (bmiEntry.weight /
                    (bmiEntry.height * bmiEntry.height));
                BlocProvider
                    .of<BmiCubit>(context)
                    .addBmiEntries(bmiEntry.modify(bmi: bmi));
              }
            }, radius: 30,);
          },
        ),
      ),
    );
  }
}
